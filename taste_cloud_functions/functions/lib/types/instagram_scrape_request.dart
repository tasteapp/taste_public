import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'instagram_scrape_request.g.dart';

@RegisterType()
mixin InstagramScrapeRequest
    on FirestoreProto<$pb.InstagramScrapeRequest>, UserOwned {
  static final triggers =
      trigger<InstagramScrapeRequest>(create: (r) => r.createScrapedUser());

  static int get numScrapers => 4;

  Future createScrapedUser() async {
    final user = (await CollectionType.users.coll
                .where('instagram_info.username', isEqualTo: proto.username)
                .limit(1)
                .get())
            .documents
            .firstOrNull
            ?.reference ??
        await createDummyUser();
    if (user == null) {
      await deleteSelf();
      return;
    }
    final index = await getScraperIndex();
    await updateSelf({
      'user': user,
      'index': index,
      'priority': proto.hasPriority() ? proto.priority : 5,
      'ignore_most_recent': proto.ignoreMostRecent,
      'failed': false,
    });
  }

  Future<DocumentReference> createDummyUser() async {
    final record = await admin.auth().createUser(CreateUserRequest(
        displayName: proto.username,
        email: '${proto.username}@trytaste.app',
        password: proto.username));
    var numAttempts = 0;
    while (numAttempts < 10) {
      final user = await getStringRef('users/${record.uid}');
      if (user.exists) {
        await user.reference.updateData(
            UpdateData.fromMap({'instagram_info.username': proto.username}));
        return user.reference;
      }
      numAttempts++;
      await Future.delayed(const Duration(seconds: 6));
    }
    return null;
  }

  Future<int> getScraperIndex() async {
    final indexes = (await CollectionType.instagram_scrape_requests.coll
            .where('failed', isEqualTo: false)
            .select(['index']).get())
        .documents
        .where((i) => i.data.has('index'))
        .map((i) => i.data.getInt('index'));
    if (indexes.isEmpty) {
      return 0;
    }
    final counter = Iterable<int>.generate(numScrapers).toMap((t) => 0);
    indexes.forEach((i) => counter.containsKey(i) ? counter[i]++ : null);
    return counter.keys.min((t) => counter[t]);
  }
}

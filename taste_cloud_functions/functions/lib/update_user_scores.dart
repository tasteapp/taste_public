import 'package:taste_cloud_functions/taste_functions.dart';

Future updateUserScores() => autoBatch((t) async {
      final users = (await CollectionType.users.coll.select([]).get())
          .documents
          .map((x) => x.reference)
          .toSet();
      return (await tasteBQ(
              '''SELECT user, score FROM `$projectId.firestore_export.user_scores`''',
              (x) => MapEntry(x[0].ref, int.parse(x[1]))))
          .mapify
          .where((k, v) => users.contains(k))
          .entries
          .futureMap(
              (ref, score) async => t.update(ref, {'score': score}.updateData));
    });

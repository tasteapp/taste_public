import 'package:crypto/crypto.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb
    show UserPostsStartingLocation;

part 'user_posts_starting_locations.g.dart';

@RegisterType()
mixin UserPostsStartingLocation
    on FirestoreProto<$pb.UserPostsStartingLocation> {
  static void registerInternal() {
    final fn = tasteFunctions.pubsub
        .schedule('every 24 hours')
        .onRun((message, context) => userPostsStartingLocations());
    registerFunction('user_posts_starting_locations', fn, fn);
  }
}

Future userPostsStartingLocations() => autoBatch((t) async => (await tasteBQ(
        '''
          SELECT username, lat, lng
          FROM 
          `$projectId.firestore_export.user_posts_starting_location`
        ''',
        (x) => {
              'username': x[0],
              'location': GeoPoint(
                double.parse(x[1]),
                double.parse(x[2]),
              )
            }.asProto($pb.UserPostsStartingLocation())))
    .where((e) => e.username.isNotEmpty)
    .futureMap((e) async => t.set(
        // Use a hash of the username to ensure we don't create duplicate
        // records for multiple usernames. We can't use usernames since they
        // could potentially have characters not allowed by Firestore as key.
        CollectionType.user_posts_starting_locations.coll
            .document(md5.convert(utf8.encode(e.username)).toString()),
        e.documentData)));

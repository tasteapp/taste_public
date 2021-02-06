import 'package:taste_cloud_functions/instagram_util.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

part 'instagram_location.g.dart';

@RegisterType()
mixin InstagramLocation on FirestoreProto<$pb.InstagramLocation> {
  static final triggers =
      trigger<InstagramLocation>(update: (l, c) => l.updateInstaPosts(c));

  Future updateInstaPosts(Change<InstagramLocation> change) async {
    if (change.fieldChanged('fb_location') &&
        !proto.hasFbLocation() &&
        change.before.proto.fbLocation.hasFbPlaceId()) {
      await deleteRestoAndUpdateInstaPosts(change.before.proto.fbLocation);
      return;
    }
    if (!(change.fieldChanged('queried_location') && proto.queriedLocation)) {
      return;
    }
    if (proto.hasFbLocation()) {
      await restaurantByFbPlace(proto.fbLocation, true);
    }
    final posts = (await wrapQuery(
        CollectionType.insta_posts.coll
            .where('instagram_location.id', isEqualTo: proto.id)
            .where('has_review', isEqualTo: false),
        InstaPosts.make));
    for (final post in posts) {
      if (post.proto.doNotUpdate) {
        continue;
      }
      final update = proto.hasFbLocation()
          ? {'fb_location': proto.fbLocation.asMap, 'is_homecooked': false}
          : {'is_homecooked': true};
      await post.updateSelf(update);
    }
  }

  Future deleteRestoAndUpdateInstaPosts($pb.FacebookLocation fbLocation) async {
    final resto = (await CollectionType.restaurants.coll
            .where('attributes.fb_place_id', isEqualTo: fbLocation.fbPlaceId)
            .limit(1)
            .get()
            .then((s) =>
                s.documents.map((r) => Restaurants.make(r, transaction))))
        .firstOrNull;
    if (resto == null) {
      return;
    }
    await resto.deleteSelf();
    final posts = (await wrapQuery(
        CollectionType.insta_posts.coll
            .where('instagram_location.id', isEqualTo: proto.id),
        InstaPosts.make));
    for (final post in posts) {
      if (post.proto.doNotUpdate || !post.proto.hasFbLocation()) {
        continue;
      }
      print("Deleting fb place from post: ${post.ref.path}");
      await post.updateSelf({'fb_location': Firestore.fieldValues.delete()});
    }
  }
}

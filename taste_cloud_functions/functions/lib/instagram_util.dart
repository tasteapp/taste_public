import 'dart:async';
import 'dart:convert';

import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_cloud_functions/types/instagram_location.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

Future<List<InstaPost>> instaPosts(
        DocumentReference user, String username, BatchedTransaction t) =>
    InstaPosts.get(
        trans: t,
        queryFn: (q) => q
            .where('user', isEqualTo: user)
            .where('username', isEqualTo: username));

Future<int> createInstaPosts(List<$pb.InstaPost> posts,
    List<InstaPost> previousImports, BatchedTransaction t) async {
  final postLinks = previousImports.map((e) => e.proto.link).toSet();
  final newPosts = posts.where((e) => !postLinks.contains(e.link)).toList();
  for (final post in newPosts) {
    print('Added post for ${post.username}: ${post.link}');
    final reference = CollectionType.insta_posts.coll.document();
    await t.set(reference, postDocumentData(post));
  }
  return newPosts.length;
}

// Necessary because calling .documentData turns some strings into timestamps
// for some reason.
DocumentData postDocumentData($pb.InstaPost post) {
  final data = post.documentData;
  if (post.hasInstagramLocation() && post.instagramLocation.hasId()) {
    final instagramLocationData = data.getNestedData('instagram_location')
      ..setString('id', post.instagramLocation.id);
    data.setNestedData('instagram_location', instagramLocationData);
  }
  return data;
}

bool locationIsCity(String locationName) {
  final splitName = locationName.split(', ');
  return splitName.length > 1 && stateAbbreviations.containsKey(splitName.last);
}

Future<DocumentReference> restaurantByFbPlace(
    $pb.FacebookLocation fbPlace, bool hidden,
    {bool createNew = true}) async {
  final resto = await CollectionType.restaurants.coll
      .where('attributes.fb_place_id', isEqualTo: fbPlace.fbPlaceId)
      .limit(1)
      .get();
  if (resto.documents.isNotEmpty) {
    return resto.documents.first.reference;
  }
  if (!createNew) {
    return null;
  }
  final reference = CollectionType.restaurants.coll.document();
  final data = {
    'attributes': {
      'location': {
        'latitude': fbPlace.location.latitude,
        'longitude': fbPlace.location.longitude,
      },
      'name': fbPlace.name,
      'address': fbPlace.address,
      'fb_place_id': fbPlace.fbPlaceId,
      'categories': fbPlace.categories,
      'phone': fbPlace.phone,
      'website': fbPlace.website,
      'hours': fbPlace.hours,
    },
    'from_hidden_review': hidden,
  }.ensureAs($pb.Restaurant());
  await reference.setData(DocumentData.fromMap(data));
  return reference;
}

$pb.FacebookLocation createFacebookLocation(FacebookPlaceResult place) =>
    $pb.FacebookLocation()
      ..fbPlaceId = place.id
      ..name = place.name
      ..location = ($pb.LatLng()
        ..latitude = place.lat
        ..longitude = place.lng)
      ..address = place.address
      ..categories.addAll(place.categories)
      ..phone = place.phone
      ..website = place.website
      ..hours = place.hours;

Future<List<$pb.ImageLabel>> getImageLabels(List<int> imageBytes) async =>
    (await tasteVision.labels(imageBytes))
        .entries
        .entryMap((label, confidence) => {
              'label': label,
              'confidence': confidence
            }.asProto($pb.ImageLabel()))
        .sorted((e) => e.confidence, desc: true)
        .take(10)
        .toList();

bool isFoodOrDrink(List<$pb.ImageLabel> mlLabels) {
  for (final label in mlLabels) {
    if (label.label != 'food' && label.label != 'drink') {
      continue;
    }
    if (label.confidence > 0.6) {
      return true;
    }
  }
  return false;
}

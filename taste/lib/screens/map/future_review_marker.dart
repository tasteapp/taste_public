import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taste/screens/profile/post_interface.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/memoize.dart';

import 'review_marker.dart';

abstract class FutureReviewBackendMarker with Memoizer, ReviewMarker {
  Future<Post> get review;

  @override
  DocumentReference get reference => restaurantRef;

  Future<TasteUser> get tasteUser async => (await review)?.user;

  // TODO(team): handle multiple photos on map?
  @override
  Future<FirePhoto> get photoUrl async => (await review).firePhoto;

  @override
  Future<String> get userUrl => memoize(
      () async => (await tasteUser)?.profileImage(thumb: true), 'userUrl');

  @override
  bool get hasPhoto => true;
}

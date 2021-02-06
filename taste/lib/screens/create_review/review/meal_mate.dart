import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:taste/algolia/search_result.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste_protos/taste_protos.dart' show DiscoverItem_User;

part 'meal_mate.freezed.dart';

extension on SearchResult {
  String get name => snapshot['name'] as String;
  String get username => snapshot['username'] as String;
  String get photo => snapshot['profile_pic_url'] as String;
}

@freezed
abstract class MealMate with _$MealMate, EquatableMixin {
  MealMate._();
  factory MealMate.searchResult(SearchResult searchResult) = _SearchResult;
  factory MealMate.user({@required TasteUser user, String profilePic}) = _User;
  factory MealMate.itemUser(DiscoverItem_User itemUser) = _ItemUser;

  static Future<MealMate> reference(DocumentReference r) async {
    final user = await r.fetch<TasteUser>();
    final photo = user.profileImage();
    return MealMate.user(user: user, profilePic: photo);
  }

  @late
  String get username => when(
        searchResult: (s) => s.username,
        user: (user, _) => user.username,
        itemUser: (user) => user.name,
      );
  @late
  String get name => when(
        searchResult: (s) => s.name,
        user: (user, _) => user.name,
        itemUser: (user) => user.name,
      );
  @late
  String get photo => when(
        searchResult: (s) => s.photo,
        user: (_, photo) => photo,
        itemUser: (user) => user.photo,
      );
  @late
  DocumentReference get ref => when(
        searchResult: (s) => s.reference,
        user: (user, _) => user.reference,
        itemUser: (user) => user.reference.ref,
      );

  @override
  List<DocumentReference> get props => [ref];
}

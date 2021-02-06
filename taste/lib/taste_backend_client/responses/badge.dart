import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taste/screens/profile/badge_page.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import '../backend.dart';
import 'badge_type.dart';
import 'snapshot_holder.dart';

export 'badge_type.dart';

class Badge extends SnapshotHolder<$pb.Badge> with UserOwned {
  Badge(DocumentSnapshot snapshot) : super(snapshot);

  static $pb.Badge get newProto => $pb.Badge();

  $pb.Badge_BadgeType get type => proto.type;
  BadgeDetails get details => type.details;

  int get countValue => proto.countData.count;
  int get sortRank => details.sortRank;
  bool get isActive => level != null;
  bool get isInactive => !isActive;
  BadgeLevel get level => details.level(this);
  Widget get icon => details.icon(this);

  bool get unlocked => level != null;

  Map<String, dynamic> get analyticsPayload => {'badge': type.name};

  Widget sizedIcon(double size) =>
      size == null ? icon : details.sizedIcon(size, this);

  Stream<List<Badge>> get leaderboard => badgeLeaderboard(this);

  Future goTo(
      [TasteUser user, Map<String, dynamic> moreAnalytics = const {}]) async {
    user ??= await this.user;
    TAEvent.tapped_badge({
      ...moreAnalytics,
      'badge': type.name,
    });
    return quickPush(
        TAPage.badge_page, (context) => BadgePage(badge: this, user: user));
  }
}

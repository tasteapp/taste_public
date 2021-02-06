import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:s2geometry/s2geometry.dart';
import 'package:taste/components/icons.dart';
import 'package:taste/components/nav/nav.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/profile/profile.dart';
import 'package:taste/screens/user_list/user_list.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/geocoding_manager.dart';
import 'package:taste/taste_backend_client/responses/restaurant.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import 'logging.dart';

export 'package:rxdart/rxdart.dart';

export 'analytics.dart';

const double kMetersPerMile = 1609.34;
const _kFBProviderId = 'facebook.com';

Future<bool> alwaysTrue() async {
  return true;
}

List<Widget> mapWithPadding(List<Widget> widgets, {EdgeInsets padding}) {
  return widgets
      .map(
        (w) => Padding(
          padding: padding,
          child: w,
        ),
      )
      .toList();
}

double latLngDistance(LatLng a, LatLng b) =>
    S2LatLng.fromDegrees(a.latitude, a.longitude)
        .getDistance(S2LatLng.fromDegrees(b.latitude, b.longitude))
        .meters;

Future<bool> hasConnectedWithFb() async {
  final user = await FirebaseAuth.instance.currentUser();
  final fbProvider = user.providerData.firstWhere(
      (providerData) => providerData.providerId == _kFBProviderId,
      orElse: () => null);
  return fbProvider != null;
}

Map<String, List<Restaurant>> groupRestaurantsBySimpleAddress(
        Iterable<Restaurant> places) =>
    places.groupBy((p) => p.address);

Future<void> launchUrl(String url, BuildContext context) async {
  if (await url_launcher.canLaunch(url)) {
    await url_launcher.launch(url);
  } else {
    snackBarString('Failed to open link.'
        ' Please visit $url from your browser.');
  }
}

Future showOkayMessageDialog(
        {@required BuildContext context, @required String message}) =>
    showDialog(
        context: context,
        builder: (context) => TasteDialog(
              title: '$message',
              buttons: [
                TasteDialogButton(
                    text: 'Ok', onPressed: () => Navigator.of(context).pop()),
              ],
            ));

Future<void> showLikedUsers({
  BuildContext context,
  List<UserListUser> users,
}) =>
    quickPush(TAPage.likes,
        (context) => UserList(users: users ?? [], title: 'Likes'));

class _CountRecordWidget extends StatelessWidget {
  const _CountRecordWidget({
    @required this.stream,
    @required this.color,
    @required this.icon,
    this.textColor = Colors.black,
    this.size,
  });

  final Stream<int> stream;
  final Color textColor;
  final Color color;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: stream,
        builder: (context, snapshot) {
          final count = max(0, snapshot.data ?? 0);
          return Visibility(
            visible: count > 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: reactionCountWidget(
                icon,
                count,
                color: color,
                textColor: textColor,
                size: size,
              ),
            ),
          );
        });
  }
}

class RestaurantCountsWidget extends StatelessWidget {
  const RestaurantCountsWidget(
      {Key key,
      this.restaurantRef,
      this.iconSize,
      this.iconColor = Colors.white,
      this.textColor = Colors.white})
      : super(key: key);
  final DocumentReference restaurantRef;
  final double iconSize;
  final Color iconColor;
  final Color textColor;

  Future<Restaurant> restaurant(BuildContext context) async =>
      Restaurant.make(await restaurantRef.get());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Restaurant>(
        future: restaurant(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          final restaurant = snapshot.data;
          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
              child: Wrap(alignment: WrapAlignment.start, children: [
                _CountRecordWidget(
                  icon: TrophyOutlineIcons.trophy,
                  stream: restaurant.favorites.map((l) => l.length),
                  color: iconColor,
                  textColor: textColor,
                  size: iconSize,
                ),
                _CountRecordWidget(
                  icon: Icons.favorite_border,
                  stream: restaurant.loves,
                  color: iconColor,
                  textColor: textColor,
                  size: iconSize,
                ),
                _CountRecordWidget(
                  icon: Icons.thumb_up,
                  stream: restaurant.ups,
                  color: iconColor,
                  textColor: textColor,
                  size: iconSize,
                ),
                _CountRecordWidget(
                  icon: Icons.thumb_down,
                  stream: restaurant.downs,
                  color: iconColor,
                  textColor: textColor,
                  size: iconSize,
                ),
              ]));
        });
  }
}

Widget reactionCountWidget(
  IconData icon,
  int count, {
  Color color = Colors.yellow,
  Color textColor = Colors.white,
  double size,
}) {
  double textSize = size == null ? 15.0 : size - 2.0;
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: size ?? 18.0, color: color),
      const SizedBox(width: 7.0),
      Text(
        count.toString(),
        style: TextStyle(
          fontSize: textSize,
          fontFamily: "Rubik",
          color: textColor,
        ),
      ),
    ],
  );
}

T printIdentity<T>(T t) {
  logger.d(t);
  return t;
}

void qprint(dynamic a,
        [dynamic a1,
        dynamic a2,
        dynamic a3,
        dynamic a4,
        dynamic a5,
        dynamic a6,
        dynamic a7,
        dynamic a8,
        dynamic a9,
        dynamic a10,
        dynamic a11]) =>
    logger.d(([a] +
            [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11]
                .takeWhile((a) => a != null)
                .toList())
        .join(', '));

Future<bool> quickPop<T>([T value]) => activeNav.maybePop(value);

Future<T> quickPush<T>(TAPage page, WidgetBuilder builder,
    {PageTransitionsTheme transitionsTheme}) {
  return activeNav.push(TasteMaterialPageRoute(
      settings: RouteSettings(name: page.name, arguments: page),
      builder: builder,
      transitionsTheme: transitionsTheme));
}

String getYearMonthDay() {
  final now = DateTime.now();
  return '${now.year}${now.month}${now.day}';
}

Future goToUserProfile(DocumentReference userReference, {Object hero}) async {
  assert(CollectionType.users.isA(userReference));
  final path = userReference.path;
  TAEvent.go_to_profile({'tapped_user': path});
  final user = await userReference.fetch<TasteUser>();
  return quickPush(
      TAPage.profile_page, (_) => ProfilePage(tasteUser: user, heroTag: hero));
}

Future<$pb.Restaurant_Attributes_Address> geocoded(LatLng location) async {
  final address = await getAddress(location);
  if (address == null) {
    return null;
  }
  return {
    'street': address.thoroughfare ?? address.subThoroughfare,
    'city': address.locality ?? address.subLocality,
    'state': address.adminArea ?? address.adminAreaShort,
    'country': address.countryName,
    'source': $pb.Restaurant_Attributes_Address_Source.google_geocoder,
    'source_location': {
      'latitude': location.latitude,
      'longitude': location.longitude,
    }
  }.asProto($pb.Restaurant_Attributes_Address());
}

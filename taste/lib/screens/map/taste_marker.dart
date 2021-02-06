import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:taste/screens/map/search_result_review_marker.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/debug.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

import 'map_page.dart';
import 'review_marker.dart';

class TasteMarkerData {
  TasteMarkerData(
      {@required this.reviewMarker,
      @required this.clusterCount,
      @required this.isAnyActive,
      @required this.position,
      @required this.isActive,
      @required this.isFanned,
      @required this.isOffstage});
  final ReviewMarker reviewMarker;
  final Vector2 position;
  final bool isActive;
  final bool isFanned;
  bool get isCluster => clusterCount > 1;
  final int clusterCount;
  final bool isAnyActive;
  final bool isOffstage;
}

const double kActiveImageSize = 160.0;
const double kActiveImagePadding = 25.0;
const double kTitlePadding = 26.0;

class TasteMarkerWidget extends StatelessWidget {
  TasteMarkerWidget(
      {@required this.tasteMarkerData, @required this.mapPageState})
      : super(key: Key(tasteMarkerData.reviewMarker.key));
  final TasteMarkerData tasteMarkerData;
  final MapPageState mapPageState;

  ReviewMarker get marker => tasteMarkerData.reviewMarker;
  Future<String> get name => marker.name;
  Color get borderColor => hasFavorite
      ? const Color.fromRGBO(185, 145, 52, 1).withOpacity(0.75)
      : active
          ? Colors.green[500]
          : isFanned
              ? Colors.black.withOpacity(0.5)
              : Colors.white.withOpacity(0.7);
  Future<String> get iconFuture =>
      (marker.numFavorites + marker.score) > 0 ? marker.userUrl : null;
  Resolution get photoRes => active ? Resolution.medium : Resolution.thumbnail;
  bool get isFanned => tasteMarkerData.isFanned;
  double get iconSize => active ? 80 : isFanned ? 25 : 40;
  double get clusterIconSize => iconSize * (clusterCount >= 10 ? 0.65 : 0.5);
  double get fullImageSize => active ? kActiveImageSize : isFanned ? 50 : 80;
  double get fullImagePadding => active ? kActiveImagePadding : 10;
  double get widgetHeight => fullImageSize + fullImagePadding + titlePadding;
  double get widgetWidth => fullImageSize + fullImagePadding;
  double get borderWidth => isFanned ? 0.7 : active ? 3 : hasFavorite ? 2 : 1;
  bool get hasFavorite => (tasteMarkerData.reviewMarker.numFavorites ?? 0) > 0;
  bool get active => tasteMarkerData.isActive;
  double get opacity => active ? 1 : anyActive ? 0.25 : 0.85;
  double get textOpacity => active ? 1 : anyActive ? 0.25 : 1;
  bool get isCluster => tasteMarkerData.isCluster;
  bool get isFacebook => marker is FacebookRestaurantMarker;
  bool get showTitle => isFacebook || (!active && !isCluster && !isFanned);
  double get left => position.x - leftOffset;
  double get top => position.y - topOffset;
  Vector2 get position => tasteMarkerData.position;
  double get leftOffset => widgetWidth * 0.5;
  double get topOffset => widgetHeight * 0.5;
  Color get backgroundColor => Colors.white.withOpacity(0.6);
  double get titlePadding => showTitle ? kTitlePadding : 0.0;
  bool get anyActive => tasteMarkerData.isAnyActive;
  int get clusterCount => tasteMarkerData.clusterCount;
  bool get showCount => clusterCount > 0 && !active;
  double get countOpacity => anyActive ? 0.25 : 1.0;
  bool get isUserPage => mapPageState.user != null;
  String get watermarkAsset => 'assets/ui/taste_watermark.png';
  String get tasteLogoAsset => 'assets/ui/taste_app_icon_ios_no_alpha.png';
  String get fillerAsset => hasFavorite ? tasteLogoAsset : watermarkAsset;

  @override
  Widget build(BuildContext context) {
    final icon = iconFuture == null
        ? Container()
        : FutureBuilder<String>(
            future: iconFuture,
            builder: (_, snapshot) {
              final imageReady = snapshot.hasData;
              final iconImage = CircleAvatar(
                  backgroundColor: backgroundColor,
                  backgroundImage: imageReady
                      ? CachedNetworkImageProvider(snapshot.data)
                      : null);
              return Container(
                  height: iconSize,
                  width: iconSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: backgroundColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.7),
                          blurRadius: 2,
                          offset: const Offset(2, 2))
                    ],
                    border: Border.all(
                      color: Colors.white.withOpacity(opacity),
                      width: 0.5,
                    ),
                  ),
                  child: Opacity(
                    opacity: opacity,
                    child: iconImage,
                  ));
            });
    final clusterCountWidget = Container(
        height: clusterIconSize,
        width: clusterIconSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor.withOpacity(countOpacity),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 4,
                offset: const Offset(2, 2))
          ],
          border: Border.all(
            color: Colors.black.withOpacity(opacity),
            width: 1,
          ),
        ),
        child: Opacity(
          opacity: countOpacity,
          child: Center(
            child: Text(
              clusterCount < 100 ? "+$clusterCount" : "+..",
              maxLines: 1,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Rubik',
                  color: Colors.black.withOpacity(countOpacity),
                  shadows: [
                    Shadow(
                      color: Colors.white.withOpacity(countOpacity),
                      blurRadius: 4,
                    )
                  ]),
              textAlign: TextAlign.center,
            ),
          ),
        ));
    final fullImage = FutureBuilder<FirePhoto>(
        future: marker.photoUrl,
        builder: (context, firePhotoSnapshot) {
          return Container(
            height: fullImageSize,
            width: fullImageSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: backgroundColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(2, 2))
              ],
              border: Border.all(
                color: borderColor.withOpacity(opacity),
                width: borderWidth,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(fullImageSize * 0.5),
              child: !firePhotoSnapshot.hasData
                  ? Image.asset(
                      fillerAsset,
                      fit: BoxFit.cover,
                    )
                  : Opacity(
                      opacity: opacity,
                      child: firePhotoSnapshot.data.progressive(
                        photoRes,
                        Resolution.thumbnail,
                        BoxFit.cover,
                        height: fullImageSize,
                        width: fullImageSize,
                      ),
                    ),
            ),
          );
        });
    final nameWidget = FutureBuilder<String>(
        future: name,
        initialData: "",
        builder: (_, snapshot) => AutoSizeText(snapshot.data,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Lalezar',
              color: Colors.black.withOpacity(textOpacity),
              decorationThickness: 1.5,
              shadows: [
                Shadow(
                  color: Colors.white.withOpacity(textOpacity),
                  blurRadius: 10,
                )
              ],
            ),
            textAlign: TextAlign.center,
            minFontSize: 11,
            overflow: TextOverflow.fade,
            maxLines: 1));
    return Positioned(
        left: left,
        top: top,
        child: Offstage(
          offstage: tasteMarkerData.isOffstage,
          child: Container(
            height: widgetHeight,
            width: widgetWidth,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      right: fullImagePadding,
                      bottom: fullImagePadding + titlePadding),
                  child: fullImage,
                ),
                Visibility(
                  visible: !isFanned && !isUserPage,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: titlePadding),
                    child: icon,
                  ),
                ),
                Visibility(
                    visible: showTitle,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: widgetWidth,
                        child: nameWidget,
                      ),
                    )),
                Align(
                  alignment: Alignment.topRight,
                  child: Visibility(
                    visible: showCount,
                    child: clusterCountWidget,
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Visibility(
                      visible: tasteDebugMode(context),
                      child: Container(
                        color: Colors.white,
                        child: Text(
                          tasteMarkerData.reviewMarker.score.toString(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}

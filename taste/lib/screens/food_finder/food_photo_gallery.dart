import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:taste/screens/food_finder/food_finder_manager.dart';
import 'package:taste/screens/restaurant/restaurant_page.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/fire_photo.dart';

class FoodPhotoGallery extends StatefulWidget {
  const FoodPhotoGallery(
      {Key key,
      this.bloc,
      this.restaurantRef,
      this.coverPhotos,
      this.photoHeight,
      this.bottomPadding})
      : super(key: key);
  final FoodFinderManager bloc;
  final DocumentReference restaurantRef;
  final List<CoverPhotoData> coverPhotos;
  final double photoHeight;
  final double bottomPadding;

  @override
  FoodPhotoGalleryState createState() => FoodPhotoGalleryState();
}

class FoodPhotoGalleryState extends State<FoodPhotoGallery>
    with SingleTickerProviderStateMixin {
  int photoIndex;
  PreloadPageController controller;

  void blocEvent(Function() func) => widget.bloc != null ? func() : null;

  @override
  void initState() {
    super.initState();
    photoIndex = 0;
    controller = PreloadPageController();
    blocEvent(() => widget.bloc.add(FoodFinderEvent.setActiveDiscoverItem(
        widget.restaurantRef, photoIndex)));
  }

  void prevImage() {
    setState(() {
      photoIndex =
          photoIndex > 0 ? photoIndex - 1 : widget.coverPhotos.length - 1;
      controller.animateToPage(photoIndex,
          duration: 100.millis, curve: Curves.linear);
      blocEvent(() => widget.bloc.add(FoodFinderEvent.setActiveDiscoverItem(
          widget.restaurantRef, photoIndex)));
    });
  }

  void nextImage() {
    setState(() {
      photoIndex = (photoIndex + 1) % widget.coverPhotos.length;
      controller.animateToPage(photoIndex,
          duration: 100.millis, curve: Curves.linear);
      blocEvent(() => widget.bloc.add(FoodFinderEvent.setActiveDiscoverItem(
          widget.restaurantRef, photoIndex)));
    });
  }

  List<CoverPhotoData> get coverPhotos => widget.coverPhotos?.isEmpty ?? true
      ? [CoverPhotoData(firePhoto: emptyFirePhoto)]
      : widget.coverPhotos;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PreloadPageView.builder(
              itemCount: coverPhotos.length,
              itemBuilder: (c, i) => FoodFinderCoverPhoto(
                coverPhoto: coverPhotos[i],
                height: widget.photoHeight * 1.35,
                width: constraints.maxWidth,
              ),
              preloadPagesCount: 3,
              controller: controller,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: coverPhotos.length > 1,
                child: Padding(
                  padding: EdgeInsets.only(bottom: widget.bottomPadding),
                  child: SmoothPageIndicator(
                    effect: ScrollingDotsEffect(
                      maxVisibleDots: 5,
                      dotHeight: 10,
                      dotWidth: 10,
                      radius: 5,
                      activeDotScale: 1.2,
                      activeDotColor: Colors.white,
                      dotColor: Colors.white.withOpacity(0.5),
                    ),
                    controller: controller,
                    count: coverPhotos.length,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: prevImage,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                heightFactor: 1.0,
                alignment: Alignment.topLeft,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            GestureDetector(
              onTap: nextImage,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                heightFactor: 1.0,
                alignment: Alignment.topRight,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      );
}

class FoodFinderCoverPhoto extends StatelessWidget {
  const FoodFinderCoverPhoto(
      {this.coverPhoto, this.onTap, this.height, this.width});
  final CoverPhotoData coverPhoto;
  final Function() onTap;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        width: width,
        child: CoverPhoto(
          coverPhoto,
          onTap: onTap ?? () {},
        ),
      );
}

class SelectedPhotoIndicator extends StatelessWidget {
  const SelectedPhotoIndicator({this.photoIndex, this.photoCount});
  final int photoIndex;
  final int photoCount;

  @override
  Widget build(BuildContext context) => photoCount > 1
      ? Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: Iterable<int>.generate(photoCount)
                .map((i) => PhotoIndicator(active: i == photoIndex))
                .toList(),
          ),
        )
      : Container();
}

class PhotoIndicator extends StatelessWidget {
  const PhotoIndicator({this.active});
  final bool active;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Container(
            height: 3.0,
            decoration: BoxDecoration(
              color: active ? Colors.white : Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2.5),
              boxShadow: active
                  ? const [
                      BoxShadow(
                          color: Color(0x22000000),
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                          offset: Offset(0.0, 1.0))
                    ]
                  : null,
            ),
          ),
        ),
      );
}

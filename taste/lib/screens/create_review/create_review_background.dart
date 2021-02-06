import 'dart:math';

import 'package:flutter/material.dart';

const kDesignScreenWidth = 414.0;
const kDesignScreenHeight = 846.0;

class CreateReviewBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height - kBottomNavigationBarHeight,
      width: size.width,
      child: Stack(children: const [
        PostingComponent(
            name: "assets/posting/picnic_table.png",
            top: 558,
            left: -221.91,
            width: 816,
            height: 503),
        PostingComponent(
            name: "assets/posting/green_decoration_blob.png",
            top: 0,
            left: -277.89,
            width: 518,
            height: 492),
        PostingComponent(
            name: "assets/posting/orange_decoration_blob.png",
            top: 46,
            left: 214,
            width: 272,
            height: 218),
        PostingComponent(
            name: "assets/posting/squiggle_decorations.png",
            top: 96,
            left: 34,
            width: 503,
            height: 504),
        PostingComponent(
            name: "assets/posting/office_worker.png",
            top: 439,
            left: 162,
            width: 267,
            height: 288),
      ]),
    );
  }
}

class PostingComponent extends StatelessWidget {
  const PostingComponent(
      {this.name, this.top, this.left, this.width, this.height});
  final String name;
  final double top;
  final double left;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double scaleFactor = screenSize.width / kDesignScreenWidth;
    return Positioned(
      top: topDistance(screenSize, top),
      left: left * (1 + scaleFactor) / 2,
      width: width * scaleFactor,
      height: height * scaleFactor,
      child: Image.asset(name),
    );
  }
}

double topDistance(Size screenSize, double top) {
  double scaleFactor = screenSize.width / kDesignScreenWidth;
  double effectiveHeight = screenSize.height - kBottomNavigationBarHeight;
  return top * scaleFactor -
      max(0.0, (kDesignScreenHeight * scaleFactor - effectiveHeight) * 0.65);
}

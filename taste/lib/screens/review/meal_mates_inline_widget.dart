import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taste/components/profile_photo.dart';
import 'package:taste/screens/profile/post_interface.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste/utils/utils.dart';

import 'meal_mates_page.dart';

class MealMatesInlineWidget extends StatelessWidget {
  const MealMatesInlineWidget({
    Key key,
    @required this.review,
    @required this.mates,
  })  : assert(review != null),
        assert(mates != null),
        super(key: key);

  final DocumentReference review;
  final List<DocumentReference> mates;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: mates.isNotEmpty,
        child: Card(
            color: Colors.white.withOpacity(0.5),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: InkWell(
              onTap: () async => goToMealMatesPage(context,
                  review: await spinner<Review>(review.fetch)),
              child:
                  RowSuper(innerDistance: -9, invert: true, children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: const [
                    Card(
                        color: Colors.white,
                        elevation: 5,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(Icons.people, size: 8),
                        )),
                    Card(
                        color: Colors.grey,
                        elevation: 5,
                        shape: CircleBorder(),
                        child: Padding(
                          padding: EdgeInsets.all(1.0),
                          child: Icon(Icons.restaurant, size: 4),
                        )),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: RowSuper(
                        innerDistance: -4,
                        mainAxisSize: MainAxisSize.min,
                        invert: true,
                        children: mates
                            .map((e) => Hero(
                                  tag: MealMateHeroTag(user: e, review: review),
                                  child: ProfilePhoto(
                                    user: e,
                                    radius: 9,
                                  ),
                                ))
                            .toList()))
              ]),
            )));
  }
}

Future goToMealMatesPage(BuildContext context, {@required Post review}) =>
    quickPush(TAPage.meal_mates_page, (_) => MealMatesPage(review: review));

class MealMatesBuilder extends StatelessWidget {
  const MealMatesBuilder(
      {Key key, @required this.review, @required this.builder})
      : super(key: key);
  final Post review;
  final Widget Function(BuildContext context, List<TasteUser> usernames)
      builder;

  @override
  Widget build(BuildContext context) => FutureBuilder<List<TasteUser>>(
      future: review.mealMates.futureMap((s) => s.fetch()),
      builder: (c, s) => builder(c, s.data));
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:taste/screens/contest/daily_tasty_badge.dart';
import 'package:taste/screens/discover/components/heart.dart';
import 'package:taste/screens/profile/post_interface.dart';
import 'package:taste/screens/review/review.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/reaction.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/debug.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/posts_list_provider.dart';
import 'package:taste_protos/photo_regexp.dart';

import '../../app_config.dart';
import 'quick_edit_post_restaurant_button.dart';

const kDishColor = Color(0xFF6D7278);
const kRestoNameColor = Color(0xFF949AA2);

class SimpleReviewWidget extends StatelessWidget {
  const SimpleReviewWidget({
    Key key,
    @required this.review,
    this.showMulti = true,
  }) : super(key: key);

  final Post review;
  final bool showMulti;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 161.5),
      child: InkWell(
        onTap: () {
          TAEvent.click_post();
          PostsListProvider.go(context, review);
        },
        onLongPress: isProd ? null : toggleTasteDebugMode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Card(
                  elevation: 0,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: ReviewPhoto(review: review, showMulti: showMulti),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!review.isEmptyInstagramDish)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Row(
                      children: [
                        Expanded(
                            child: review.shouldShowAddDish
                                ? AddDishWidget(
                                    instaPost: review.instaPost,
                                    fontSize: 15,
                                    minFontSize: 12,
                                    maxLines: 1,
                                    color: kDishColor)
                                : DishNameWidget(
                                    text: review.displayDish,
                                    fontSize: 15,
                                    minFontSize: 12,
                                    maxLines: 1,
                                    color: kDishColor)),
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: review.reaction.baseReaction.icon(size: 18),
                        ),
                      ],
                    ),
                  ),
                if (!review.isEmptyInstagramDish) const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Row(
                    children: [
                      QuickEditPostRestaurantButton(
                          post: review,
                          padding: const EdgeInsets.only(right: 8.0)),
                      Expanded(
                        child: AutoSizeText(
                          review.isHomeCooked
                              ? 'Home-cooked'
                              : 'From ${review.restaurantName}',
                          style: TextStyle(
                            color: review.isEmptyInstagramDish
                                ? kDishColor
                                : kRestoNameColor,
                            fontSize: review.isEmptyInstagramDish ? 15 : 12,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          minFontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                if (review.isEmptyInstagramDish) const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewPhoto extends StatelessWidget {
  const ReviewPhoto({Key key, this.review, @required this.showMulti})
      : super(key: key);

  final Post review;
  final bool showMulti;

  @override
  Widget build(BuildContext context) => DoubleTapHeartWidget(
        onDoubleTap: () => review.like(true),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            review.firePhoto.progressive(
              Resolution.medium,
              Resolution.thumbnail,
              BoxFit.cover,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            review.isMultiPhoto && (showMulti ?? true)
                ? const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Ionicons.md_albums, color: Colors.white),
                  )
                : null,
            review.hasDailyTasty
                ? const Positioned(
                    bottom: 4, right: 4, child: DailyTastyBadge(size: 13))
                : null,
            StreamBuilder<Restaurant>(
              stream: review.restaurant,
              builder: (context, snapshot) {
                if (!snapshot.hasData || !snapshot.data.blackOwned) {
                  return Container();
                }
                return Positioned(
                    left: 5,
                    bottom: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 30,
                      width: 30,
                      child: Image.asset('assets/ui/black_power.png'),
                    ));
              },
            ),
          ].withoutNulls,
        ),
      );
}

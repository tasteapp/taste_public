import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/restaurant_lookup/restaurant_lookup.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/loading.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'post_interface.dart';

class QuickEditPostRestaurantButton extends StatelessWidget {
  const QuickEditPostRestaurantButton(
      {Key key,
      @required this.post,
      this.size = 15,
      @required this.padding,
      this.resetWidget,
      this.okWidget,
      this.didSwitchTypes})
      : super(key: key);
  final Post post;
  final double size;
  final EdgeInsets padding;
  final Widget resetWidget;
  final Widget okWidget;
  final void Function() didSwitchTypes;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: post.shouldShowEditRestaurant,
        child: Row(
          children: [
            InkWell(
                onTap: () async => [
                      post.postReference.updateData({'freeze_place': true}),
                      post.discoverItem.then(
                          (d) => d.reference.updateData({'freeze_place': true}))
                    ].wait,
                child: Padding(
                  padding: padding,
                  child: okWidget ??
                      Icon(Icons.check, size: size, color: kPrimaryButtonColor),
                )),
            InkWell(
              onTap: () async {
                await (await searchForRestaurantPush(
                        title: 'Set place for "${post.dish}"',
                        homeCookedOption: true))
                    .when(
                        homeCooked: () async {
                          await spinner(() async {
                            await (Firestore.instance.batch()
                                  ..updateData(
                                      post.postReference,
                                      {
                                        'freeze_place': true,
                                        'meal_type':
                                            $pb.Review_MealType.meal_type_home,
                                        'restaurant': null,
                                        'restaurant_name': null,
                                        'address': null,
                                        'restaurant_location': null,
                                      }.ensureAs($pb.Review(),
                                          explicitNulls: true,
                                          explicitEmpties: true))
                                  ..updateData(
                                      (await post.discoverItem).reference,
                                      {
                                        'freeze_place': true,
                                        'restaurant': null,
                                        'meal_type':
                                            $pb.Review_MealType.meal_type_home,
                                      }.ensureAs($pb.DiscoverItem(),
                                          explicitNulls: true,
                                          explicitEmpties: true)))
                                .commit();
                          });
                          snackBarString('Your post will update soon');
                          if (post.postReference.type ==
                              CollectionType.reviews) {
                            (didSwitchTypes ?? () {})();
                          }
                        },
                        empty: () => null,
                        place: (fbPlace) async {
                          await spinner(() async {
                            final itemFuture = post.discoverItem;
                            final restaurant = await restaurantByFbPlace(
                                fbPlace,
                                create: true);
                            await (Firestore.instance.batch()
                                  ..updateData(
                                      post.postReference,
                                      {
                                        'freeze_place': true,
                                        'restaurant': restaurant.reference,
                                        'restaurant_name': restaurant.name,
                                        'address':
                                            restaurant.proto.attributes.address,
                                        'restaurant_location':
                                            restaurant.location.geoPoint
                                      }.ensureAs($pb.Review()))
                                  ..updateData(
                                      (await itemFuture).reference,
                                      {
                                        'freeze_place': true,
                                        'restaurant': {
                                          'reference': restaurant.reference,
                                          'name': restaurant.name,
                                          'address': restaurant
                                              .proto.attributes.address,
                                        }
                                      }.ensureAs($pb.DiscoverItem())))
                                .commit();
                          });
                          snackBarString('Your post will update soon');
                          if (post.postReference.type ==
                              CollectionType.home_meals) {
                            (didSwitchTypes ?? () {})();
                          }
                        });
              },
              child: Padding(
                padding: padding,
                child: resetWidget ??
                    Icon(
                      Icons.clear,
                      size: size,
                      color: Colors.red,
                    ),
              ),
            ),
          ],
        ),
      );
}

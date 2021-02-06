import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taste/screens/create_review/review/create_review.dart';
import 'package:taste/screens/create_review/review/data_correctness.dart';
import 'package:taste/screens/create_review/review/restaurant_chip_selector.dart';
import 'package:taste/screens/restaurant_lookup/restaurant_lookup.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste_protos/taste_protos.dart';

import 'create_review_bloc.dart';
import 'post_photo_manager.dart';

class ChosenPlaceWidget extends CreateReviewChildWidget {
  ChosenPlaceWidget({this.name, this.address}) : super();

  final String name;
  final Restaurant_Attributes_Address address;

  @override
  Widget childBuild(
      BuildContext context,
      PostPhotoManager bloc,
      CreateReviewBlocState state,
      CreateReviewBloc reviewBloc,
      PostPhotoState photoState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RestaurantNameWidget(
              name: name ?? state.fbPlace.name,
              address: address ?? state.fbPlace.address),
        ),
        state.isBlackOwned
            ? Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 0.5,
                      spreadRadius: 0.0,
                      offset: Offset(0.5, 0.5),
                    )
                  ],
                ),
                child: IconButton(
                  padding: const EdgeInsets.all(3.0),
                  onPressed: () {
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'The place you selected is a Black Owned business.')));
                  },
                  icon: Image.asset('assets/ui/black_power.png'),
                ),
              )
            : null,
        state.isBlackOwned ? const SizedBox(width: 22.0) : null,
        reviewBloc.isUpdate
            ? null
            : InkWell(
                onTap: () async {
                  TAEvent.clicked_clear_restaurant();
                  reviewBloc.add(const CreateReviewBlocEvent.removeFbPlace());
                },
                child: const Icon(
                  Icons.clear,
                  color: Color(0xFF707070),
                  size: 20.0,
                ),
              ),
      ].withoutNulls,
    );
  }
}

class ChoseHomecookedWidget extends CreateReviewChildWidget {
  @override
  Widget childBuild(
      BuildContext context,
      PostPhotoManager bloc,
      CreateReviewBlocState state,
      CreateReviewBloc reviewBloc,
      PostPhotoState photoState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "Homecooked (no place required)",
            style: reviewTextStyle(fontSize: 18),
            maxLines: 1,
          ),
        ),
        reviewBloc.isUpdate
            ? null
            : InkWell(
                onTap: () {
                  TAEvent.discover_toggle_home_cooked({'state': state.isHome});
                  reviewBloc.add(const CreateReviewBlocEvent.toggleVariable(
                      PostVariable.homeCooking));
                },
                child: const Icon(
                  Icons.clear,
                  color: Color(0xFF707070),
                  size: 18.0,
                ),
              ),
      ].withoutNulls,
    );
  }
}

class SelectPlaceWidget extends CreateReviewChildWidget {
  @override
  Widget childBuild(
      BuildContext context,
      PostPhotoManager bloc,
      CreateReviewBlocState state,
      CreateReviewBloc reviewBloc,
      PostPhotoState photoState) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: AddPlaceWidget(),
      ),
      state.suggestions == null
          ? const Center(child: CircularProgressIndicator())
          : state.suggestions.isEmpty
              ? const SizedBox()
              : const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: RestaurantChipsSelector()),
                ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child:
            Align(alignment: Alignment.centerLeft, child: HomecookedSelector()),
      ),
    ]);
  }
}

class AddPlaceWidget extends CreateReviewChildWidget {
  @override
  Widget childBuild(
      BuildContext context,
      PostPhotoManager bloc,
      CreateReviewBlocState state,
      CreateReviewBloc reviewBloc,
      PostPhotoState photoState) {
    return InkWell(
      onTap: () async {
        await (await searchForRestaurantPush()).when(
            empty: () {
              TAEvent.favorites_place_lookup_no_selection();
            },
            homeCooked: () => null, // Not handled in UI right now
            place: (result) async {
              TAEvent.selected_restaurant_from_search(
                  {'selected': state.fbPlace != null});
              reviewBloc
                ..add(CreateReviewBlocEvent.fbPlace(result))
                ..unfocus(context);
              await checkIfBlackOwned(context, result, reviewBloc);
            });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add Place',
            style: reviewTextStyle(
              fontSize: 16,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF707070),
            size: 18.0,
          ),
        ],
      ),
    );
  }
}

class RestaurantNameWidget extends StatelessWidget {
  const RestaurantNameWidget({Key key, this.name, this.address})
      : super(key: key);

  final String name;
  final Restaurant_Attributes_Address address;

  @override
  Widget build(BuildContext context) =>
      TwoLineRestoName(name: name, address: address.detailed);
}

class TwoLineRestoName extends StatelessWidget {
  const TwoLineRestoName({Key key, this.name, this.address}) : super(key: key);

  final String name;
  final String address;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AutoSizeText(
          name,
          style: reviewTextStyle(fontSize: 18.0),
          maxLines: 1,
          maxFontSize: 18,
          minFontSize: 12,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2.0),
        Row(
          children: <Widget>[
            const Icon(
              Icons.place,
              size: 10,
              color: Colors.grey,
            ),
            Expanded(
              child: AutoSizeText(
                " $address",
                style: reviewTextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                maxLines: 1,
                maxFontSize: 12,
                minFontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

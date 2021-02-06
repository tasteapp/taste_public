import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taste/screens/create_review/review/create_review.dart';
import 'package:taste/screens/create_review/review/create_review_bloc.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/analytics.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/fb_places_api.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

double kRestaurantChipHeight = 41.0;

class RestaurantChipsSelector extends StatefulWidget {
  const RestaurantChipsSelector({Key key}) : super(key: key);

  @override
  _RestaurantChipsSelectorState createState() =>
      _RestaurantChipsSelectorState();
}

class _RestaurantChipsSelectorState extends State<RestaurantChipsSelector> {
  @override
  Widget build(BuildContext context) =>
      FadingEdgeScrollView.fromSingleChildScrollView(
          gradientFractionOnEnd: .07,
          gradientFractionOnStart: .07,
          child: SingleChildScrollView(
              controller: ScrollController(),
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(0),
              child: BlocBuilder<CreateReviewBloc, CreateReviewBlocState>(
                  builder: (context, state) => Row(
                      children: state.suggestions.enumerate
                          .entryMap<Widget>((i, result) =>
                              RestaurantChoiceChip(i, result, state))
                          .divide(const SizedBox(width: 7))))));
}

class RestaurantChoiceChip extends StatelessWidget {
  const RestaurantChoiceChip(
    this.i,
    this.result,
    this.state, {
    Key key,
  }) : super(key: key);
  final CreateReviewBlocState state;
  final int i;
  final FacebookPlaceResult result;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
        label: Text(
          result.name,
          style: reviewTextStyle(fontSize: 16.0),
        ),
        padding: const EdgeInsets.all(10),
        selected: true,
        backgroundColor: const Color(0xFF97cd84),
        selectedColor: const Color(0xFF97cd84),
        onSelected: (selected) async {
          if (state.fbPlace != null) {
            TAEvent.replaced_selected_restaurant_chip();
          }
          TAEvent.tapped_restaurant_chip({'index': i});
          final bloc = BlocProvider.of<CreateReviewBloc>(context)
            ..add(CreateReviewBlocEvent.fbPlace(result));
          await checkIfBlackOwned(context, result, bloc);
        });
  }
}

Future<$pb.BlackCharity> selectBlackCharity(
    BuildContext context, CreateReviewBloc bloc) async {
  final charity = await showDialog<$pb.BlackCharity>(
      context: context, builder: charityDialog);
  if (charity != null) {
    TAEvent.selected_black_charity({'charity': charity.name});
  } else {
    TAEvent.did_not_select_black_charity();
  }
  return charity;
}

Future<bool> checkIfBlackOwned(BuildContext context, FacebookPlaceResult place,
    CreateReviewBloc bloc) async {
  final resto = await restaurantByFbPlace(place);
  final blackOwned = resto?.proto?.attributes?.blackOwned ?? false;
  bloc.add(CreateReviewBlocEvent.blackOwned(blackOwned
      ? $pb.Review_BlackOwnedStatus.restaurant_black_owned
      : $pb.Review_BlackOwnedStatus.restaurant_not_black_owned));
  return blackOwned;
}

TasteDialog charityDialog(BuildContext dialogContext) => TasteDialog(
      scrollable: true,
      contentPadding: const EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 18.0),
      content: Column(
          children: List.from([
        Container(
          width: 70,
          height: 70,
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
            onPressed: null,
            icon: Image.asset('assets/ui/black_power.png'),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "Thank you for supporting the black community!\n\nTaste is donating \$5 for every post at a black owned restaurant. Select which charity you want to support below:",
            style: TextStyle(
                fontSize: 17.0, fontWeight: FontWeight.bold, color: kDarkGrey),
            textAlign: TextAlign.left,
          ),
        ),
      ])
            ..addAll(charities.keys.listMap((c) => BlackCharityTile(c)))),
    );

class BlackCharityTile extends StatelessWidget {
  const BlackCharityTile(this.charity);
  final $pb.BlackCharity charity;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: null,
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: FlatButton(
          onPressed: () => Navigator.pop(context, charity),
          splashColor: kPrimaryButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(color: Colors.grey[400], width: 2.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 60,
                child: Image.asset(charities[charity]),
              )),
        ),
      ),
    );
  }
}

const charities = {
  $pb.BlackCharity.splc: "assets/images/splc_logo.png",
  $pb.BlackCharity.eji: "assets/images/eji_logo.png",
  $pb.BlackCharity.aclu: "assets/images/aclu_logo.png",
};

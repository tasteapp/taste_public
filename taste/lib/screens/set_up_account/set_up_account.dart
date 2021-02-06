import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geohash/geohash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'package:taste/components/nav/nav.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/providers/taste_snack_bar.dart';
import 'package:taste/screens/location_lookup.dart';
import 'package:taste/screens/map/map_utils.dart';
import 'package:taste/screens/restaurant_lookup/restaurant_lookup.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/responses/taste_user.dart';
import 'package:taste/taste_backend_client/value_stream_builder.dart';
import 'package:taste/theme/buttons.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/fb_places_api.dart';
import 'package:taste/utils/mapbox_api.dart';
import 'package:taste/utils/ranking.dart';
import 'package:taste/utils/unfocusable.dart';
import 'package:taste/utils/utils.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

final _formKey = GlobalKey<FormState>(debugLabel: 'setup-account');

class _State extends ChangeNotifier {
  factory _State(
    TasteUser user,
    bool firstTimeSetup,
  ) =>
      _State._(
        user,
        user.stream
            .asyncMap((user) => user.profileImage())
            .where((url) => url?.isNotEmpty ?? false)
            .map((url) => CachedNetworkImageProvider(url))
            .asBroadcastStream(),
        firstTimeSetup,
      );
  _State._(this.user, this.imageStream, this.firstTimeSetup) {
    name.text = user.name;
    username.text = user.username.toLowerCase();
  }
  final TasteUser user;
  final bool firstTimeSetup;
  final Stream<ImageProvider> imageStream;
  final name = TextEditingController();
  final username = TextEditingController();
  final controller = PageController();
  MapboxAutocompleteResult _locationOverride;
  File _localImage;
  List<Restaurant> selections = [];
  List<Restaurant> addedByName = [];

  File get localImage => _localImage;
  MapboxAutocompleteResult get locationOverride => _locationOverride;

  set localImage(File value) {
    _localImage = value;
    notifyListeners();
  }

  set locationOverride(MapboxAutocompleteResult value) {
    _locationOverride = value;
    notifyListeners();
  }

  void addResto(Restaurant resto) {
    addedByName.add(resto);
    notifyListeners();
  }

  void addSelection(Restaurant resto) {
    if (selections.contains(resto)) {
      selections.remove(resto);
    } else {
      selections.add(resto);
    }
    notifyListeners();
  }

  Future updateImage(BuildContext context) async {
    final file = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxHeight: 1000,
        maxWidth: 1000,
        imageQuality: 60);
    if (file == null) {
      return;
    }
    final cropped = await ImageCropper.cropImage(
      maxHeight: 1000,
      maxWidth: 1000,
      compressQuality: 60,
      compressFormat: ImageCompressFormat.jpg,
      sourcePath: file.path,
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: const IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
      cropStyle: CropStyle.circle,
    );
    if (cropped == null) {
      return;
    }
    localImage = cropped;
    final uploadPhotoFn = () async {
      final photo = await uploadPhoto(cropped);
      await updateVanity({
        'photo': photo.photoReference,
        'fire_photo': photo,
      });
    };
    unawaited(uploadPhotoFn());
  }

  Future<bool> commit() async {
    final username = this.username.text.toLowerCase().trim();
    this.username.text = username;
    final name = this.name.text.trim();
    if (!_formKey.currentState.validate()) {
      return false;
    }
    final matchingUsernameDocs = (await CollectionType.users.coll
            .where('vanity.username', isEqualTo: username)
            .limit(1)
            .getDocuments())
        .documents;
    if (username != user.username.toLowerCase() &&
        matchingUsernameDocs.isNotEmpty &&
        matchingUsernameDocs.first.reference.path != user.path) {
      snackBarString('Username already taken, please select another');
      this.username.clear();
      return false;
    }
    await updateVanity({
      'username': username,
      'display_name': name,
    });
    return true;
  }
}

class _UserPropertiesPage extends StatelessWidget {
  const _UserPropertiesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<_State>();
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: MediaQuery.of(context).size.shortestSide / 6),
      child: Column(
        children: [
          StreamBuilder<ImageProvider>(
            stream: state.imageStream,
            builder: (context, snapshot) => IconButton(
              onPressed: () => state.updateImage(context),
              iconSize: MediaQuery.of(context).size.shortestSide * 0.17 * 2,
              icon: Card(
                elevation: 5,
                shape: const CircleBorder(),
                child: CircleAvatar(
                  backgroundImage: state.localImage != null
                      ? FileImage(state.localImage)
                      : snapshot.data,
                  backgroundColor: kTastePrimaryButtonOptions.color,
                  radius: MediaQuery.of(context).size.shortestSide * 0.17,
                  child: (snapshot.data == null && state.localImage == null)
                      ? Align(
                          alignment: Alignment.center,
                          child: Card(
                            color: Colors.transparent,
                            elevation: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.photo_camera,
                                color: Colors.white.withOpacity(0.7),
                                size: 35,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 15),
                TextFormField(
                  autocorrect: false,
                  textCapitalization: TextCapitalization.words,
                  controller: state.name,
                  decoration: const InputDecoration(labelText: 'Display Name'),
                  validator: (name) => name.isEmpty
                      ? 'Required'
                      : name.length < 3
                          ? 'Must have at least 3 characters'
                          : name.contains(RegExp(r'[^\sa-zA-Z0-9_]'))
                              ? 'Must be alpha-numeric'
                              : null,
                ),
                const SizedBox(height: 15),
                TextFormField(
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    controller: state.username,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (username) => username.isEmpty
                        ? 'Required'
                        : username.length < 3
                            ? 'Must have at least 3 characters'
                            : username.contains(RegExp(r'[^a-zA-Z0-9_\.]'))
                                ? 'Must be alpha-numeric'
                                : null),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const _defaultLocation = LatLng(40.740816, -73.990037);
const _defaultSearchRadiusMiles = 5;

class _PersonalizationPage extends StatelessWidget {
  const _PersonalizationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationOverride = context.select((_State s) => s.locationOverride);
    final latLng = LocationBuilder.of(context);
    final hasLocation = latLng != null;
    final location = locationOverride != null
        ? locationOverride.location
        : latLng ?? _defaultLocation;
    final bounds =
        latLngBounds(location, _defaultSearchRadiusMiles * kMetersPerMile);
    final lowerBoundGeohash =
        Geohash.encode(bounds.southwest.latitude, bounds.southwest.longitude);
    final upperBoundGeohash =
        Geohash.encode(bounds.northeast.latitude, bounds.northeast.longitude);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Text(
              'Pick 5 or more places that you like',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            TasteButton(
              text: locationOverride == null
                  ? hasLocation ? 'Your location' : 'New York City'
                  : locationOverride.name,
              options: kSimpleButtonOptions,
              iconData: Icons.location_on,
              onPressed: () async {
                final result = await Navigator.push<MapboxAutocompleteResult>(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LocationLookup()),
                );
                if (result != null) {
                  context.read<_State>().locationOverride = result;
                } else {
                  TAEvent.empty_result_from_loc_lookup();
                }
              },
            ),
            const SizedBox(width: 15),
            TasteButton(
              text: 'Find by name',
              options: kSimpleButtonOptions,
              iconData: Icons.search,
              onPressed: () async {
                final result = await Navigator.push<FacebookPlaceResult>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantLookup(
                      title: "Find place",
                      searchLocation: locationOverride?.location,
                    ),
                  ),
                );
                if (result != null) {
                  final resto = await restaurantByFbPlace(result, create: true);
                  final state = context.read<_State>();
                  if (!state.addedByName.contains(resto)) {
                    state
                      ..addResto(resto)
                      ..addSelection(resto);
                  } else {
                    Scaffold.of(context).showSnackBar(
                      const SnackBar(content: Text('Restaurant already added')),
                    );
                  }
                }
              },
            ),
          ],
        ),
        StreamBuilder<QuerySnapshot>(
          stream: CollectionType.restaurants.coll
              .where('from_hidden_review', isEqualTo: false)
              .where('geohash', isGreaterThan: lowerBoundGeohash)
              .where('geohash', isLessThan: upperBoundGeohash)
              .getDocuments()
              .asStream()
              .startWith(null),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final querySnapshot = snapshot.data;
            final allRestos = querySnapshot.documents.map(Restaurant.make);
            // ignore: avoid_types_on_closure_parameters
            final manuallyAdded =
                context.select((_State s) => s.addedByName).reversed.toList();
            final manuallyAddedPaths = manuallyAdded.map((x) => x.path).toSet();
            final filteredRestos = RestoRanking.sort(
                    restos: allRestos
                        .where((x) => !manuallyAddedPaths.contains(x.path))
                        .toAlgoliaRestaurants,
                    location: location)
                .toRestaurants;
            // final loadedPaths = filteredRestos.map((x) => x.path).toSet();
            // manuallyAdded.addAll(addedByNameAndSelectionsTuple.item2
            //     .where((s) => !loadedPaths.contains(s.path)));
            return Container(
              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                ),
                itemBuilder: (context, idx) {
                  return _PersonalizationRestoItem(
                      resto: (manuallyAdded + filteredRestos)[idx]);
                },
                itemCount: filteredRestos.length + manuallyAdded.length,
                shrinkWrap: true,
                cacheExtent: MediaQuery.of(context).size.height * 3,
                physics: const ClampingScrollPhysics(),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _PersonalizationRestoItem extends StatefulWidget {
  const _PersonalizationRestoItem({
    Key key,
    this.resto,
  }) : super(key: key);

  final Restaurant resto;

  @override
  _PersonalizationRestoItemState createState() =>
      _PersonalizationRestoItemState();
}

class _PersonalizationRestoItemState extends State<_PersonalizationRestoItem> {
  @override
  Widget build(BuildContext context) {
    final resto = widget.resto;
    return Builder(
      builder: (context) {
        final state = context.watch<_State>();
        return InkWell(
          onTap: () {
            setState(() => state.addSelection(resto));
          },
          child: Stack(
            children: [
              FutureBuilder<String>(
                future: resto.profilePicture,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: CachedNetworkImage(
                      fit: BoxFit.contain,
                      imageUrl: snapshot.data,
                    ),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.7),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AutoSizeText(
                    resto.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    minFontSize: 13,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              if (state.selections.contains(resto))
                const Align(
                  alignment: Alignment(1.1, -0.85),
                  child: RawMaterialButton(
                    onPressed: null,
                    fillColor: Colors.white,
                    padding: EdgeInsets.zero,
                    shape: CircleBorder(),
                    child: Icon(Icons.check, size: 20.0),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _PersonalizationHeader extends StatelessWidget {
  const _PersonalizationHeader({Key key}) : super(key: key);

  static const progressIndicatorPadding = 7.0;

  @override
  Widget build(BuildContext context) {
    final selectionsLength = context.watch<_State>().selections.length;
    final progressIndicatorWidth = (MediaQuery.of(context).size.width -
            5 * progressIndicatorPadding -
            30) /
        5;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          if (selectionsLength < 5)
            Row(
              children: [0, 1, 2, 3, 4]
                  .map((idx) => Padding(
                        padding: const EdgeInsets.only(
                          right: progressIndicatorPadding,
                        ),
                        child: Container(
                          width: progressIndicatorWidth,
                          height: 5,
                          color: idx <= selectionsLength - 1
                              ? kPrimaryButtonColor
                              : Colors.grey[300],
                        ),
                      ))
                  .toList(),
            ),
          if (selectionsLength >= 5)
            Container(
              width: MediaQuery.of(context).size.width - 30,
              height: 5,
              color: kPrimaryButtonColor,
            ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: AutoSizeText(
              "Let's get to know your taste",
              style: kAppBarTitleStyle.copyWith(fontSize: 25),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class SetUpAccountScreen extends StatelessWidget {
  const SetUpAccountScreen({Key key, this.firstLaunch = false})
      : super(key: key);
  final bool firstLaunch;

  @override
  Widget build(BuildContext context) {
    return LocationBuilder(
      builder: (context, latLng, status) {
        return ValueStreamBuilder<TasteUser>(
          stream: tasteUserStream,
          builder: (context, snapshot) => ChangeNotifierProvider(
            create: (_) => _State(snapshot.data, firstLaunch),
            child: Builder(
              builder: (context) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    inputDecorationTheme: const InputDecorationTheme(
                      isDense: true,
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    textTheme: Theme.of(context).textTheme.copyWith(
                          bodyText2:
                              Theme.of(context).textTheme.bodyText2.copyWith(
                                    fontSize: 15,
                                    color: kDarkGrey,
                                  ),
                        ),
                  ),
                  child: IntroductionScreen(
                    // ignore: avoid_types_on_closure_parameters
                    controller: context.select((_State s) => s.controller),
                    pages: [
                      PageViewModel(
                        titleWidget: SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Text(
                              firstLaunch
                                  ? 'Set up your profile'
                                  : 'Edit Account',
                              style: kAppBarTitleStyle.copyWith(fontSize: 21),
                            ),
                          ),
                        ),
                        bodyWidget: const _UserPropertiesPage(),
                      ),
                      if (firstLaunch)
                        PageViewModel(
                          titleWidget: const _PersonalizationHeader(),
                          bodyWidget: const _PersonalizationPage(),
                          decoration: const PageDecoration(
                            // titleTextStyle: TextStyle(color: Colors.orange),
                            bodyTextStyle: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20.0),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                          ),
                        ),
                    ],
                    onDone: () async {
                      final state = context.read<_State>();
                      if (!firstLaunch) {
                        final commitResult = await state.commit();
                        if (commitResult) {
                          showNavBar();
                          Navigator.pop(context);
                        }
                      } else {
                        if (state.selections.length > 4) {
                          await currentUserReference.setData(
                            {
                              'vanity': {'has_set_up_account': true},
                              'setup_liked_restos': state.selections
                                  .map((r) => r.reference.proto)
                                  .toList(),
                            }.ensureAs($pb.TasteUser()),
                            merge: true,
                          );
                        }
                      }
                    },
                    onNext: (i) async {
                      final state = context.read<_State>();
                      keyboardUnfocus(context);
                      if (i == 0) {
                        final commitResult = await state.commit();
                        if (!commitResult) {
                          await state.controller.animateToPage(
                            0,
                            duration: 150.millis,
                            curve: Curves.easeInOut,
                          );
                        }
                      }
                    },
                    dotsDecorator:
                        const DotsDecorator(activeColor: kPrimaryButtonColor),
                    showSkipButton: false,
                    next: const Icon(Icons.arrow_forward_ios),
                    prev: const Icon(Icons.arrow_back_ios),
                    done: const Text(
                      "Done",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    freeze: true,
                    animationDuration: 200,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

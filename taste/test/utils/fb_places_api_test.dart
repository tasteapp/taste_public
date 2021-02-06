import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/utils/fb_places_api.dart';

const kDefaultLocation = LatLng(0, 0);

FacebookPlaceResult createFakePlace(
  String name, {
  LatLng location = kDefaultLocation,
  String city = 'test city',
  String state = 'test state',
  String country = 'test country',
  String street = 'test street',
}) {
  return FacebookPlaceResult(
    id: 'test id',
    name: name,
    street: street,
    city: city,
    state: state,
    country: country,
    location: location,
    engagementCount: 0,
    hours: {},
    categories: [],
    pageId: '',
  );
}

void main() {
  test('is-restaurant', () {
    // bar is case-sensitive
    expect(isRestaurantCategory('cabaret', 0), isFalse);
    expect(isRestaurantCategory('caBaret', 0), isTrue);
    // pub is case-sensitive
    expect(isRestaurantCategory('somepub', 0), isFalse);
    expect(isRestaurantCategory('somePubasdf', 0), isTrue);
    // restaurant is not case-sensitive
    expect(isRestaurantCategory('asdfasdfrestafurantasdf', 0), isFalse);
    expect(isRestaurantCategory('asdfasdfrestaurantasdf', 0), isTrue);
    expect(isRestaurantCategory('asdfasdfResTaurantasdf', 0), isTrue);
    // gastro is not case-sensitive
    expect(isRestaurantCategory('asdfaGAStroTaurantasdf', 0), isTrue);
    expect(isRestaurantCategory('asdfaGStroTaurantasdf', 0), isFalse);
    // 110113695730808 is whitelisted
    expect(
        isRestaurantCategory('asdfaGStroTaurantasdf', 110113695730808), isTrue);
  });
  test('Duplicates check', () {
    expect(
      areDuplicates(
        createFakePlace('The Little Cafe'),
        createFakePlace('Little Cafe'),
      ),
      isTrue,
    );

    expect(
      areDuplicates(
        createFakePlace('The Mill SF'),
        createFakePlace('The Mill'),
      ),
      isTrue,
    );

    expect(
      areDuplicates(
        createFakePlace("St Regis, Ile St Louis", city: 'Paris'),
        createFakePlace("Cafe St. Regis, Ile Saint-Louis, Paris",
            city: 'Paris'),
      ),
      isTrue,
    );
  });
}

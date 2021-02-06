import 'utilities.dart';

void main() {
  setUp(setupEmulator);
  tearDown(tearDownEmulator);

  test('restaurant-photo', () async {
    final restaurant = await Fixture().restaurant;
    await restaurant.updateSelf(
        {'profile_pic_external_url': 'https://placekitten.com/100/100'});
    await eventually(
        () async =>
            (await restaurant.refetch).proto.fireProfilePic.firebaseStorage,
        isNotEmpty);
  });
}

/// Run `make run-test-script` to run this code against emulator environment.
/// !!! Start the emulator first `make emulator` !!!
import 'utilities.dart';

void main() async {
  CloudTransformProvider.initialize();
  final count = 30;
  final user = (await Fixture().user).ref;
  final photos = await autoBatch((t) => count.times.futureMap((i) async =>
      t.create('photos'.coll.document(),
          {'firebase_storage_path': '$i'}.documentData)));
  final dishes = await autoBatch(
      (t) => photos.enumerate.futureMap((i, p) async => t.create(
          'home_meals'.coll.document(),
          {
            'user': user,
            'photo': p,
            'dish': '$i',
            'meal_type': 'meal_type_home',
          }.documentData)));
  final restos =
      await autoBatch((t) => count.times.futureMap((i) async => t.create(
          'restaurants'.coll.document(),
          {
            'attributes': {'name': '$i'}
          }.documentData)));
  await autoBatch((t) => restos
      .zip(dishes)
      .futureMap((a) async => t.update(a.b, {'restaurant': a.a}.updateData)));
}

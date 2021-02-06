import 'package:taste_cloud_functions/taste_functions.dart';

final _testColl = 'fake_algolia'.coll;

Future<List<String>> testAlgoliaMessages() async => (await _testColl.get())
    .documents
    .map((d) => d.data.toMap().toString())
    .toList();

class TestAlgoliaClient extends AlgoliaClient {
  @override
  Future<AlgoliaTask> updateInternal(
      AlgoliaIndexReference index, Map<String, dynamic> json) {
    _testColl.add(json.documentData);
    return null;
  }

  @override
  Future<AlgoliaTask> deleteInternal(
          AlgoliaIndexReference index, String objectID) =>
      null;
}

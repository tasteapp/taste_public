import 'package:taste_cloud_functions/taste_functions.dart';

class AlgoliaClient {
  Future _handleTask(AlgoliaTask task) async {
    if (task == null || task is! AlgoliaTask) {
      print('AlgoliaTask is error $task');
      return;
    }
    print('AlgoliaTask $task ${task.data}');
    await task.waitTask();
  }

  Future update(AlgoliaIndexReference index, Map<String, dynamic> json) async =>
      await _handleTask(await updateInternal(index, json));
  Future delete(AlgoliaIndexReference index, String objectID) async =>
      await _handleTask(await deleteInternal(index, objectID));

  Future<AlgoliaTask> updateInternal(
          AlgoliaIndexReference index, Map<String, dynamic> json) =>
      index.addObject(json);
  Future<AlgoliaTask> deleteInternal(
          AlgoliaIndexReference index, String objectID) =>
      index.object(objectID).deleteObject();
}

final algoliaClient = buildType.isTest ? TestAlgoliaClient() : AlgoliaClient();

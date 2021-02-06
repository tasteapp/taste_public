import 'dart:typed_data';

import 'package:node_http/node_http.dart' as http;
import 'package:taste_cloud_functions/taste_functions.dart';

mixin TasteStorage {
  Future<List<int>> bytes(String firebasePath);

  Future<List<int>> urlBytes(String url);

  Future makePublic(String path);

  Future delete(String path);

  Future<Photo> uploadToStorage(String path, Uint8List bytes);
  Future<Photo> uploadUrlPhoto(String url, String path);
}

class _ProdTasteStorage with TasteStorage {
  @override
  Future<Photo> uploadToStorage(String path, Uint8List bytes) async {
    await admin.storage().bucket().file(path).upload(bytes);
    return _waitFor(path);
  }

  Future<Photo> _waitFor(String path) async {
    var iteration = 0;
    while (true) {
      final images = await Photos.get(
          queryFn: (q) =>
              q.where('firebase_storage_path', isEqualTo: path).limit(1));
      if (images.isNotEmpty) {
        return images.first;
      }
      iteration += 1;
      await Future.delayed(const Duration(milliseconds: 2700));
      if (iteration > 100) {
        print('Failed to find photo with path $path');
        return null;
      }
    }
  }

  @override
  Future<Photo> uploadUrlPhoto(String url, String path) async {
    final downloadResponse = await http.get(url);
    final bytes = downloadResponse?.bodyBytes;
    if (bytes == null) {
      return null;
    }
    await uploadToStorage(path, bytes);
    return _waitFor(path);
  }

  @override
  Future<List<int>> bytes(String firebasePath) async {
    final file = admin.storage().bucket().file(firebasePath);
    var seconds = 1;
    while (!await file.exists()) {
      print('DNE $firebasePath, sleeping $seconds seconds...');
      await Future.delayed(Duration(seconds: seconds));
      seconds *= 2;
      if (seconds > 100) {
        print('DNE $firebasePath, exiting');
        return null;
      }
    }
    return file.download();
  }

  @override
  Future<List<int>> urlBytes(String url) async =>
      (await http.get(url)).bodyBytes;

  @override
  Future makePublic(String path) =>
      admin.storage().bucket().file(path).makePublic();

  @override
  Future delete(String path) => admin.storage().bucket().file(path).delete();
}

class _FakeTasteStorage with TasteStorage {
  @override
  Future<Photo> uploadToStorage(String path, Uint8List bytes) =>
      autoBatch((t) => Photos.createNew(t,
          data: {'firebase_storage_path': path}.documentData.withExtras));

  @override
  Future<Photo> uploadUrlPhoto(String url, String path) =>
      autoBatch((t) => Photos.createNew(t,
          data: {
            'firebase_storage_path': [url, path].join(',')
          }.documentData.withExtras));
  @override
  Future<List<int>> bytes(String firebasePath) async => [];
  @override
  Future<List<int>> urlBytes(String url) async => [];

  @override
  Future makePublic(String path) async => [];

  @override
  Future delete(String path) async => [];
}

final tasteStorage = buildType.isTest
    ? _FakeTasteStorage()
    : _ProdTasteStorage() as TasteStorage;

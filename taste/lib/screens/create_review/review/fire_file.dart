import 'dart:async';
import 'dart:io';

import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste_protos/taste_protos.dart' show FirePhoto;

class FireFile {
  factory FireFile.make(File file, int identifier) =>
      FireFile._(file, uploadPhoto(file, identifier), false, identifier);
  factory FireFile.existing(File file, Future<FirePhoto> photoFuture) =>
      FireFile._(file, photoFuture ?? uploadPhoto(file), true, null);
  const FireFile._(this.file, this.photo, this._preExists, this.identifier);
  final File file;
  final Future<FirePhoto> photo;

  final bool _preExists;
  final int identifier;
  FireFile fileModified(File file) {
    delete();
    return FireFile.make(file, identifier);
  }

  Future delete() async {
    if (_preExists) {
      return;
    }
    return photo.then((value) => value.photoReference.ref.delete());
  }
}

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import 'create_review.dart';
import 'fire_file.dart';

part 'post_photo_manager.freezed.dart';

@freezed
abstract class PostPhotoEvent with _$PostPhotoEvent {
  const factory PostPhotoEvent.edited(int index, File file) = _Edited;
  const factory PostPhotoEvent.deleted(int index) = _Deleted;
  const factory PostPhotoEvent.reordered(int to, int from) = _Reordered;
  const factory PostPhotoEvent.abort() = _Abort;
  const factory PostPhotoEvent.complete(DocumentReference reference) = _Claim;
  const factory PostPhotoEvent.add(List<File> addedFiles) = _Add;
}

class PostPhotoState {
  // Defensive copy
  PostPhotoState._(List<FireFile> fireFiles)
      : _fireFiles = fireFiles.toList(growable: false);
  final List<FireFile> _fireFiles;

  List<File> get files => _fireFiles.map((e) => e.file).toList();
  List<FireFile> get _filesCopy => _fireFiles.toList();
  PostPhotoState _delete(int i) => _wrap((files) {
        assert(files.length > 1);
        files[i].delete();
        files.removeAt(i);
      });

  PostPhotoState _clear() => _wrap((files) => files
    ..forEach((e) => e.delete())
    ..clear());

  PostPhotoState _edit(int i, File file) =>
      _wrap((files) => files[i] = files[i].fileModified(file));
  PostPhotoState _add(List<File> addedFiles) => _wrap((files) => files.addAll(
      addedFiles.enumerate.listMap((a) => FireFile.make(a.value, a.key))));

  PostPhotoState _wrap(Function(List<FireFile> files) fn) {
    final files = _filesCopy;
    fn(files);
    return PostPhotoState._(files);
  }

  PostPhotoState _swap(int i, int j) => _wrap(
        (files) => files.insert(
          j.clamp(0, files.length - 1).toInt(),
          files.removeAt(
            i.clamp(0, files.length - 1).toInt(),
          ),
        ),
      );

  PostPhotoState _complete(DocumentReference reference) {
    reference.snapshots().firstWhere((e) => e.exists).then((_) async {
      final photos = await _fireFiles.futureMap((t) => t.photo);
      return reference.updateData({
        'photo': photos.first.photoReference.ref,
        'more_photos': photos.skip(1).listMap((p) => p.photoReference.ref),
        'fire_photos': photos,
      }.ensureAs($pb.Review()));
    });
    return this;
  }
}

class PostPhotoManager extends Bloc<PostPhotoEvent, PostPhotoState> {
  PostPhotoManager(CreateOrUpdateReviewWidget parent)
      : _initial = PostPhotoState._(_initialState(parent));
  final PostPhotoState _initial;

  @override
  PostPhotoState get initialState => _initial;

  @override
  Stream<PostPhotoState> mapEventToState(PostPhotoEvent event) async* {
    yield event.when(
        add: state._add,
        complete: state._complete,
        abort: state._clear,
        deleted: state._delete,
        edited: state._edit,
        reordered: state._swap);
  }

  static List<FireFile> _initialState(
    CreateOrUpdateReviewWidget parent,
  ) {
    if (parent.isUpdate) {
      return parent.images
          .zip(parent.review.firePhotos)
          .zipMap((file, photo) => FireFile.existing(file, Future.value(photo)))
          .toList();
    }
    return parent.images.enumerate
        .listMap((pair) => FireFile.make(pair.value, pair.key))
        .toList();
  }
}

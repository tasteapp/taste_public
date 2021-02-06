import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste_protos/taste_protos.dart' show indexReferencePath;

class ParentUserIndex {
  ParentUserIndex(this.parent, this.collectionType,
      {this.parentField = 'parent', this.userField = 'user'});
  factory ParentUserIndex.snapshot(
          DocumentSnapshot snapshot, CollectionType collectionType,
          {String parentField = 'parent', String userField = 'user'}) =>
      ParentUserIndex(snapshot.reference, collectionType,
          parentField: parentField, userField: userField);
  final DocumentReference parent;
  final CollectionType collectionType;
  final String parentField;
  final String userField;
  DocumentReference get user => currentUserReference;
  Future<bool> toggle(bool enable,
          {FutureOr Function(WriteBatch batch) batch}) =>
      update(enable: enable, batchFn: batch);
  Future<bool> update({
    @required bool enable,
    Map<String, dynamic> payload,
    FutureOr Function(WriteBatch batch) batchFn,
  }) async {
    final indexReference = Firestore.instance.document(indexReferencePath(
        root: collectionType,
        parentCollection: parent.parent().id,
        parentId: parent.documentID,
        userId: user.documentID));
    final batch = Firestore.instance.batch();
    await batchFn?.call(batch);
    if (enable) {
      final mainReference = payload?.isEmpty ?? true
          ? collectionType.coll.document()
          : (await record.first)?.reference ?? collectionType.coll.document();
      final mainPayload = {
        parentField: parent,
        userField: user,
        ...payload ?? {},
      }.withExtras.withoutNulls;
      batch
        ..setData(mainReference, mainPayload)
        ..setData(indexReference, {'reference': mainReference});
      await batch.commit();
      return true;
    }
    final existing = (await record.first)?.reference;
    if (existing == null) {
      throw ArgumentError(
          'no existing record for parent ${parent.path} collection $collectionType');
    }
    batch..delete(existing)..delete(indexReference);
    try {
      await batch.commit();
    } catch (e, s) {
      unawaited(Crashlytics.instance
          .recordError(e, s, context: {'failed-unique-delete': existing.path}));
      // Maybe a missing index? Try and delete it by itself.
      await existing.delete();
    }
    return true;
  }

  Query get _query => collectionType.coll.where(parentField, isEqualTo: parent);

  Stream<bool> get exists => record.map((e) => e != null);
  Stream<List<DocumentSnapshot>> get all =>
      _query.snapshots().map((s) => s.documents);

  Stream<DocumentSnapshot> get record => _query
      .where(userField, isEqualTo: user)
      .limit(1)
      .snapshots()
      .map((event) => event.documents.firstOrNull);
}

ParentUserIndex likeable(DocumentSnapshot snapshot) =>
    ParentUserIndex.snapshot(snapshot, CollectionType.likes);
ParentUserIndex voteable(DocumentSnapshot snapshot) =>
    ParentUserIndex.snapshot(snapshot, CollectionType.daily_tasty_votes,
        parentField: 'post');
ParentUserIndex likeableReference(DocumentReference reference) =>
    ParentUserIndex(reference, CollectionType.likes);
ParentUserIndex favoriteable(DocumentSnapshot snapshot) =>
    ParentUserIndex.snapshot(snapshot, CollectionType.favorites,
        parentField: 'restaurant');
ParentUserIndex followable(DocumentSnapshot snapshot) =>
    ParentUserIndex.snapshot(snapshot, CollectionType.followers,
        parentField: 'following', userField: 'follower');

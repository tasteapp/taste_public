import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:protobuf/protobuf.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/utils/memoize.dart';
import 'package:taste_protos/taste_protos.dart' as $pb;

import '../taste_backend_client.dart';

mixin _ProtoHolder {
  GeneratedMessage get proto;
  dynamic byName(String name) =>
      proto.getField(proto.info_.byName[name].tagNumber);
}

mixin UserOwned on _ProtoHolder {
  String get userField => 'user';
  DocumentReference get userReference =>
      (byName(userField) as $pb.DocumentReferenceProto).ref;
  Future<TasteUser> get user async => userReference.fetch();

  bool get isMine => currentUserReference.path == userReference.path;
  bool get isNotMine => !isMine;
}

mixin ParentHolder on _ProtoHolder {
  String get parentField => 'parent';
  DocumentReference get parent =>
      (byName(parentField) as $pb.DocumentReferenceProto).ref;
}

class SnapshotHolder<P extends GeneratedMessage>
    with _ProtoHolder, EquatableMixin, Memoizer {
  SnapshotHolder(this.snapshot) : proto = snapshot.proto<P>();

  final DocumentSnapshot snapshot;
  @override
  final P proto;
  DocumentReference get reference => snapshot.reference;

  bool get exists => snapshot.exists;
  bool get notExists => !exists;
  bool get isNotReady => snapshot?.data == null;
  DateTime get createTime => createdAt?.toDate();
  Timestamp get createdAt =>
      createdAtTimestamp ??
      (snapshot.metadata.hasPendingWrites ? Timestamp.now() : null);
  Timestamp get createdAtTimestamp => extras["created_at"] as Timestamp;
  DateTime get updateTime => (extras["updated_at"] as Timestamp).toDate();
  Map<String, dynamic> get extras =>
      Map.from(snapshot.data["_extras"] as Map ?? {});
  Future report({String text}) => reportContentCall(reference, text: text);
  Future delete() => reference.delete();
  String get path => reference.path;
  Key get key => Key(path);

  @override
  List<String> get props => [path];
}

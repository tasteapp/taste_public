import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste/taste_backend_client/taste_backend_client.dart';
import 'package:taste/utils/extensions.dart';

final recommendationsProvider = () {
  Stream<List<Set<DocumentReference>>> refs(
          DocumentReference ref, bool first) =>
      ['following', 'follower'].streamCombine((f) {
        final stream = CollectionType.followers.coll
            .where(f, isEqualTo: ref)
            .stream<Follower>()
            .map((s) => s
                .map((s) =>
                    (f == 'following' ? s.proto.follower : s.proto.following)
                        .ref)
                .toSet());
        return !first ? stream : stream.take(1);
      });
  return StreamProvider(
      create: (context) {
        return refs(currentUserReference, false).asyncMap((value) async {
          final followers = value[0];
          final following = value[1];
          final all = {...followers, ...following};
          final both = followers.intersection(following);
          return _Wrap((await all.futureMap((t) async => {
                    t,
                    ...(await refs(t, true).firstOrNull)?.flatten?.toList() ??
                        <DocumentReference>[]
                  }.difference({currentUserReference, ...following}).map(
                      (e) => MapEntry(e, both.contains(t) ? 1.5 : 1))))
              .flatten
              .multiMap
              .mapValue((k, v) => v.sum)
              .entries
              .sorted((e) => e.value, desc: true)
              .take(30)
              .keys
              .withoutNulls
              .toList());
        });
      },
      catchError: (c, e) {
        print(e);
      },
      lazy: true);
}();

List<DocumentReference> recommendations(BuildContext context) =>
    Provider.of<_Wrap>(context)?.users;

class _Wrap {
  const _Wrap(this.users);
  final List<DocumentReference> users;
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:taste/providers/location_provider.dart';
import 'package:taste/taste_backend_client/responses/discover_item.dart';
import 'package:taste/utils/collection_type.dart';
import 'package:taste/utils/extensions.dart';
import 'package:taste/utils/utils.dart';

enum DiscoverMode { nearby, most_recent }

final _count = BehaviorSubject.seeded(10);
const _IGPostsKeepFraction = 0.5;

Stream<List<DiscoverItem>> getDiscoverStream(DiscoverMode mode) {
  switch (mode) {
    case DiscoverMode.nearby:
      return Rx.combineLatest2<Set<String>, int, MapEntry<int, Set<String>>>(
          myLocationStream.withoutNulls
              .map((l) =>
                  tiles(l.latitude, l.longitude, 11, 30 * kMetersPerMile))
              .distinct(setEquals)
              .log((x) => x.join(' ')),
          _count,
          (tiles, count) => MapEntry(count, tiles)).switchMap(
        (pair) => CollectionType.discover_items.coll
            .where('hidden', isEqualTo: false)
            .where('show_on_discover_feed', isEqualTo: true)
            .where('spatial_index.levels',
                arrayContainsAny: pair.value.toList())
            .orderBy('score', descending: true)
            .limit(pair.key)
            .getDocuments(source: Source.server)
            .asStream()
            .map((snapshots) => snapshots.documents.listMap(
                  (snapshot) => DiscoverItem(snapshot),
                )),
      );
    case DiscoverMode.most_recent:
      return _count.switchMap(
        (count) => CollectionType.discover_items.coll
            .where('hidden', isEqualTo: false)
            .where('show_on_discover_feed', isEqualTo: true)
            .orderBy('date', descending: true)
            // 2x count since we remove 50% of IG imports.
            .limit(count * 2)
            .getDocuments(source: Source.server)
            .asStream()
            .map(
          (snapshots) {
            final items = snapshots.documents
                .listMap((snapshot) => DiscoverItem(snapshot));
            final showedPosts =
                items.listWhere((i) => !i.proto.isInstagramPost);
            final instaPosts = items.listWhere((i) => i.proto.isInstagramPost);
            for (final post in instaPosts) {
              final random = Random(post.path.hashCode);
              if (random.nextDouble() < _IGPostsKeepFraction) {
                showedPosts.add(post);
              }
            }
            return showedPosts.tupleSort((t) => [-t.proto.date.seconds]);
          },
        ),
      );
    default:
      throw UnimplementedError('Unknown DiscoverMode: $mode');
  }
}

void setDiscoverCount(int count) =>
    count > _count.value ? _count.add(count) : null;

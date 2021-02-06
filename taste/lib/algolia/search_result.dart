import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taste/taste_backend_client/backend.dart';

class SearchResult {
  SearchResult(this.reference, this.snapshot);
  final DocumentReference reference;
  final Map<String, dynamic> snapshot;

  LatLng get location {
    return LatLng(
      (snapshot['_geoloc']['lat'] as double) * 1.0,
      (snapshot['_geoloc']['lng'] as double) * 1.0,
    );
  }

  String get key => reference.path;

  int get score => (snapshot["score"] ?? 0) as int;

  DocumentReference get user {
    final path = ((snapshot["user"] ?? {})["path"] ?? "") as String;
    return path.isEmpty ? null : path.ref;
  }
}

import 'review_marker.dart';

class Cluster {
  Cluster({this.parent});
  final ReviewMarker parent;
  final List<ReviewMarker> children = [];
  final List<ReviewMarker> fanned = [];
  Iterable<ReviewMarker> get parentAndChildren => [parent, ...children];

  static Cluster init(ReviewMarker marker) => Cluster(parent: marker);

  Cluster add(ReviewMarker marker) {
    if (marker == parent) {
      return this;
    }
    children.add(marker);
    return this;
  }
}

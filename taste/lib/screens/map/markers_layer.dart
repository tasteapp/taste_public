import 'package:flutter/material.dart';

import 'map_page.dart';
import 'taste_marker.dart';

class MarkersLayer extends StatelessWidget {
  const MarkersLayer({@required this.markerData, @required this.mapPageState});
  final List<TasteMarkerData> markerData;
  final MapPageState mapPageState;

  @override
  Widget build(BuildContext context) {
    final widgets = markerData
        .map((datum) => TasteMarkerWidget(
              tasteMarkerData: datum,
              mapPageState: mapPageState,
            ))
        .toList();
    return Stack(
      children: widgets.reversed.toList(),
    );
  }
}

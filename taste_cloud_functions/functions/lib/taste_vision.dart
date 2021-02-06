import 'dart:convert';

import 'package:googleapis/vision/v1.dart';
import 'package:taste_cloud_functions/taste_functions.dart';
import 'package:taste_protos/taste_protos.dart'
    show InferenceResult_LocalizedObjectAnnotation;

final tasteVision =
    buildType.isTest ? _FakeTasteVision() : _TasteVision() as TasteVision;

class _FakeTasteVision with TasteVision {
  @override
  Future<List<InferenceResult_LocalizedObjectAnnotation>> annotations(
          List<int> bytes) async =>
      [
        {
          'name': 'burger',
          'locale': 'en-us',
          'score': 0.5,
          'bounding_poly': {
            'vertices': [0.2, 0.4, 0.4, 0.2]
                .zip([0.3, 0.3, 0.5, 0.5]).listMap((t) => {'x': t.a, 'y': t.b}),
          },
        }.asProto(InferenceResult_LocalizedObjectAnnotation())
      ];

  @override
  Future<Map<String, double>> labels(List<int> bytes) async => {'burger': 0.5};
}

mixin TasteVision {
  Future<Map<String, double>> labels(List<int> bytes);
  Future<List<InferenceResult_LocalizedObjectAnnotation>> annotations(
      List<int> bytes);
}

class _TasteVision with TasteVision {
  /// detectionType: See Feature.type in googleapis/vision/v1.dart.
  Future<AnnotateImageResponse> getImageLabels(
    List<int> bytes,
    String detectionType,
  ) async {
    if (bytes == null) {
      print('getImageLabels received failed to get image. url: $bytes');
      return null;
    }
    final api = VisionApi(await authenticatedHttpClient);
    final features = [
      Feature.fromJson({'type': detectionType})
    ];
    final image = Image.fromJson({'content': base64Encode(bytes)});
    final request = AnnotateImageRequest()
      ..image = image
      ..features = features;
    final batchRequest = BatchAnnotateImagesRequest.fromJson({
      'requests': [request.toJson()]
    });
    final response = await api.images.annotate(batchRequest);
    return response.responses.first;
  }

  @override
  Future<List<InferenceResult_LocalizedObjectAnnotation>> annotations(
          List<int> bytes) async =>
      ((await getImageLabels(bytes, 'OBJECT_LOCALIZATION'))
                  .localizedObjectAnnotations ??
              [])
          .listMap((entity) => {
                'name': entity.name,
                'locale': entity.languageCode,
                'score': entity.score,
                'bounding_poly': {
                  'vertices': entity.boundingPoly?.normalizedVertices?.listMap(
                    (v) => {
                      'x': v.x ?? 0,
                      'y': v.y ?? 0,
                    },
                  )
                },
              }.asProto(InferenceResult_LocalizedObjectAnnotation()));

  @override
  Future<Map<String, double>> labels(List<int> bytes) async =>
      (await getImageLabels(bytes, 'LABEL_DETECTION'))
          .labelAnnotations
          .mapMap((t) => MapEntry(t.description.toLowerCase(), t.score));
}

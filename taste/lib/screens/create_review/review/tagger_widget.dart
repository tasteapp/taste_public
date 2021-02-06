import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:taste/taste_backend_client/backend.dart';
import 'package:taste_protos/extensions.dart';

import '../../../utils/extensions.dart';

final _cloud = FirebaseVision.instance.cloudImageLabeler();
final _local = FirebaseVision.instance.imageLabeler();

Stream<Set<String>> autoTags(List<File> images) => [_cloud, _local]
    .cartesian(images)
    .zipMap((labeler, file) => labeler
        .processImage(FirebaseVisionImage.fromFile(file))
        .asStream()
        .startWith([]))
    .combineLatest
    .map((labels) => labels.flatten
        .sorted((a) => -a.confidence)
        .distinctOn((a) => a.text)
        .map((x) => x.text.toLowerCase())
        .where((element) => element
            .split(' ')
            .followedBy([element]).any(foodTypesWhitelist.contains))
        .where((element) => !foodTypesBlacklist.contains(element))
        .map((e) => foodTypesRemap[e] ?? toFoodType(e))
        .withoutNulls
        .map((e) => e.displayString)
        .toSet());

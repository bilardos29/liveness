import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mnc_identifier_face/model/liveness_detection_result_release_mode/liveness_detection_result_release_mode.dart';
import 'package:mnc_identifier_face/model/liveness_detection_result/detection_result.dart';
import 'package:mnc_identifier_face/model/liveness_detection_result/liveness_detection_result.dart';
export 'model/liveness_detection_result/liveness_detection_result.dart';

enum DetectionMode { HOLD_STILL, BLINK, OPEN_MOUTH, SMILE, SHAKE_HEAD }

class MncIdentifierFace {
  final MethodChannel _methodChannel =
      const MethodChannel('mnc_identifier_face');

  Future<LivenessDetectionResult?> startLivenessDetection({
    List<DetectionMode>? detectionModes,
  }) async {
    try {
      final livenessResultRawData = await _methodChannel.invokeMethod(
        'startLivenessDetection',
        {'detectionMode': detectionModes?.map((e) => e.name).toList()},
      );

      // print("-MNC- : $livenessResultRawData");

      final rawJson = jsonDecode(livenessResultRawData);
      late LivenessDetectionResult livenessDetectionResult;
      // if (kReleaseMode) {
      //   final res = LivenessDetectionResultReleaseMode.fromJson(rawJson);
      //   livenessDetectionResult = LivenessDetectionResult(
      //     isSuccess: res.g,
      //     errorMessage: res.h,
      //     totalTimeMilis: res.i,
      //     detectionResult: res.j
      //         ?.map(
      //           (e) => DetectionResult(
      //             detectionMode: e.g,
      //             image: e.h,
      //             imagePath: e.i,
      //             timeMilis: e.j,
      //           ),
      //         )
      //         .toList(),
      //     attempt: res.k,
      //   );
      // } else {
        livenessDetectionResult =
            LivenessDetectionResult.fromJson(jsonDecode(livenessResultRawData));
      // }
      // print(livenessDetectionResult.toJson());
      return livenessDetectionResult;
    } catch (e, s) {
      // if (kDebugMode) {
      log('-MNC- :$e $s');
      // }
      return null;
    }
  }
}

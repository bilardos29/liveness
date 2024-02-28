import 'package:collection/collection.dart';

import 'package:mnc_identifier_face/model/liveness_detection_result/detection_result.dart';

class LivenessDetectionResult {
  const LivenessDetectionResult({
    this.attempt,
    this.detectionResult,
    this.errorMessage,
    this.isSuccess,
    this.totalTimeMilis,
  });

  factory LivenessDetectionResult.fromJson(Map<String, dynamic> json) {
    return LivenessDetectionResult(
      attempt: json['attempt'] as int?,
      detectionResult: (json['detectionResult'] as List<dynamic>?)
          ?.map((e) => DetectionResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      errorMessage: json['errorMessage'] as String?,
      isSuccess: json['isSuccess'] as bool?,
      totalTimeMilis: json['totalTimeMilis'] as int?,
    );
  }

  final int? attempt;
  final List<DetectionResult>? detectionResult;
  final String? errorMessage;
  final bool? isSuccess;
  final int? totalTimeMilis;

  Map<String, dynamic> toJson() => {
        'attempt': attempt,
        'detectionResult': detectionResult?.map((e) => e.toJson()).toList(),
        'errorMessage': errorMessage,
        'isSuccess': isSuccess,
        'totalTimeMilis': totalTimeMilis,
      };

  LivenessDetectionResult copyWith({
    int? attempt,
    List<DetectionResult>? detectionResult,
    String? errorMessage,
    bool? isSuccess,
    int? totalTimeMilis,
  }) {
    return LivenessDetectionResult(
      attempt: attempt ?? this.attempt,
      detectionResult: detectionResult ?? this.detectionResult,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      totalTimeMilis: totalTimeMilis ?? this.totalTimeMilis,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LivenessDetectionResult) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      attempt.hashCode ^
      detectionResult.hashCode ^
      errorMessage.hashCode ^
      isSuccess.hashCode ^
      totalTimeMilis.hashCode;
}

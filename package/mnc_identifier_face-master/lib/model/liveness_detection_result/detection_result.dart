import 'package:collection/collection.dart';

import 'package:mnc_identifier_face/model/liveness_detection_result/image.dart';

class DetectionResult {
  const DetectionResult({
    this.detectionMode,
    this.image,
    this.imagePath,
    this.timeMilis,
  });

  factory DetectionResult.fromJson(Map<String, dynamic> json) {
    return DetectionResult(
      detectionMode: json['detectionMode'] as String?,
      image: json['image'] == null
          ? null
          : Image.fromJson(json['image'] as Map<String, dynamic>),
      imagePath: json['imagePath'] as String?,
      timeMilis: json['timeMilis'] as int?,
    );
  }
  final String? detectionMode;
  final Image? image;
  final int? timeMilis;
  final String? imagePath;

  Map<String, dynamic> toJson() => {
        'detectionMode': detectionMode,
        'image': image?.toJson(),
        'imagePath': imagePath,
        'timeMilis': timeMilis,
      };

  DetectionResult copyWith({
    String? detectionMode,
    Image? image,
    String? imagePath,
    int? timeMilis,
  }) {
    return DetectionResult(
      detectionMode: detectionMode ?? this.detectionMode,
      image: image ?? this.image,
      imagePath: imagePath ?? this.imagePath,
      timeMilis: timeMilis ?? this.timeMilis,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! DetectionResult) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      detectionMode.hashCode ^
      image.hashCode ^
      imagePath.hashCode ^
      timeMilis.hashCode;
}

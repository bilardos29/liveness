import 'package:collection/collection.dart';

import 'package:mnc_identifier_face/model/liveness_detection_result_release_mode/j.dart';

class LivenessDetectionResultReleaseMode {
  LivenessDetectionResultReleaseMode({
    this.g,
    this.h,
    this.i,
    this.j,
    this.k,
  });

  factory LivenessDetectionResultReleaseMode.fromJson(
    Map<String, dynamic> json,
  ) {
    return LivenessDetectionResultReleaseMode(
      g: json['g'] as bool?,
      h: json['h'] as String?,
      i: json['i'] as int?,
      j: (json['j'] as List<dynamic>?)
          ?.map((e) => J.fromJson(e as Map<String, dynamic>))
          .toList(),
      k: json['k'] as int?,
    );
  }

  bool? g;
  String? h;
  int? i;
  List<J>? j;
  int? k;

  Map<String, dynamic> toJson() => {
        'g': g,
        'h': h,
        'i': i,
        'j': j?.map((e) => e.toJson()).toList(),
        'k': k,
      };

  LivenessDetectionResultReleaseMode copyWith({
    bool? g,
    String? h,
    int? i,
    List<J>? j,
    int? k,
  }) {
    return LivenessDetectionResultReleaseMode(
      g: g ?? this.g,
      h: h ?? this.h,
      i: i ?? this.i,
      j: j ?? this.j,
      k: k ?? this.k,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LivenessDetectionResultReleaseMode) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      g.hashCode ^ h.hashCode ^ i.hashCode ^ j.hashCode ^ k.hashCode;
}

import 'package:collection/collection.dart';

import 'package:mnc_identifier_face/model/liveness_detection_result/image.dart';

class J {
  J({this.g, this.h, this.i, this.j});

  factory J.fromJson(Map<String, dynamic> json) => J(
        g: json['g'] as String?,
        h: json['h'] == null
            ? null
            : Image.fromJson(json['h'] as Map<String, dynamic>),
        i: json['i'] as String?,
        j: json['j'] as int?,
      );

  String? g;
  Image? h;
  String? i;
  int? j;

  Map<String, dynamic> toJson() => {
        'g': g,
        'h': h?.toJson(),
        'i': i,
        'j': j,
      };

  J copyWith({
    String? g,
    Image? h,
    String? i,
    int? j,
  }) {
    return J(
      g: g ?? this.g,
      h: h ?? this.h,
      i: i ?? this.i,
      j: j ?? this.j,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! J) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => g.hashCode ^ h.hashCode ^ i.hashCode ^ j.hashCode;
}

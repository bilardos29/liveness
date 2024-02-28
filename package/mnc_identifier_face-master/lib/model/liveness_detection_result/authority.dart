import 'package:collection/collection.dart';

class Authority {
  const Authority({this.decoded, this.encoded});

  factory Authority.fromJson(Map<String, dynamic> json) => Authority(
        decoded: json['decoded'] as String?,
        encoded: json['encoded'] as String?,
      );

  final String? decoded;
  final String? encoded;

  Map<String, dynamic> toJson() => {
        'decoded': decoded,
        'encoded': encoded,
      };

  Authority copyWith({
    String? decoded,
    String? encoded,
  }) {
    return Authority(
      decoded: decoded ?? this.decoded,
      encoded: encoded ?? this.encoded,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Authority) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => decoded.hashCode ^ encoded.hashCode;
}

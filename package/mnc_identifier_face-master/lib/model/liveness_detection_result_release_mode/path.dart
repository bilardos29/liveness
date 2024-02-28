import 'package:collection/collection.dart';

class Path {
  Path({this.decoded, this.encoded});

  factory Path.fromJson(Map<String, dynamic> json) => Path(
        decoded: json['decoded'] as String?,
        encoded: json['encoded'] as String?,
      );

  String? decoded;
  String? encoded;

  Map<String, dynamic> toJson() => {
        'decoded': decoded,
        'encoded': encoded,
      };

  Path copyWith({
    String? decoded,
    String? encoded,
  }) {
    return Path(
      decoded: decoded ?? this.decoded,
      encoded: encoded ?? this.encoded,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Path) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => decoded.hashCode ^ encoded.hashCode;
}

import 'package:collection/collection.dart';

import 'package:mnc_identifier_face/model/liveness_detection_result/authority.dart';
import 'package:mnc_identifier_face/model/liveness_detection_result/path.dart';

class Image {
  const Image({
    this.authority,
    this.path,
    this.scheme,
    this.uriString,
    this.host,
    this.port,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        authority: json['authority'] == null
            ? null
            : Authority.fromJson(json['authority'] as Map<String, dynamic>),
        path: json['path'] == null
            ? null
            : Path.fromJson(json['path'] as Map<String, dynamic>),
        scheme: json['scheme'] as String?,
        uriString: json['uriString'] as String?,
        host: json['host'] as String?,
        port: json['port'] as int?,
      );
  final Authority? authority;
  final Path? path;

  final String? scheme;
  final String? uriString;
  final String? host;
  final int? port;

  Map<String, dynamic> toJson() => {
        'authority': authority?.toJson(),
        'path': path?.toJson(),
        'scheme': scheme,
        'uriString': uriString,
        'host': host,
        'port': port,
      };

  Image copyWith({
    Authority? authority,
    Path? path,
    String? scheme,
    String? uriString,
    String? host,
    int? port,
  }) {
    return Image(
      authority: authority ?? this.authority,
      path: path ?? this.path,
      scheme: scheme ?? this.scheme,
      uriString: uriString ?? this.uriString,
      host: host ?? this.host,
      port: port ?? this.port,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Image) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      authority.hashCode ^
      path.hashCode ^
      scheme.hashCode ^
      uriString.hashCode ^
      host.hashCode ^
      port.hashCode;
}

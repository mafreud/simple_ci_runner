// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class BuildData {
  final int id;
  final String created_at;
  final String branch;
  final String repository_url;
  final String build_certificate_base64;
  final String build_provision_profile_base64;
  final int build_number;
  final bool is_under_processing;
  final bool status;
  final String pat;
  final String firebase_cli_token;
  BuildData({
    required this.id,
    required this.created_at,
    required this.branch,
    required this.repository_url,
    required this.build_certificate_base64,
    required this.build_provision_profile_base64,
    required this.build_number,
    required this.is_under_processing,
    required this.status,
    required this.pat,
    required this.firebase_cli_token,
  });

  BuildData copyWith({
    int? id,
    String? created_at,
    String? branch,
    String? repository_url,
    String? build_certificate_base64,
    String? build_provision_profile_base64,
    int? build_number,
    bool? is_under_processing,
    bool? status,
    String? pat,
    String? firebase_cli_token,
  }) {
    return BuildData(
      id: id ?? this.id,
      created_at: created_at ?? this.created_at,
      branch: branch ?? this.branch,
      repository_url: repository_url ?? this.repository_url,
      build_certificate_base64:
          build_certificate_base64 ?? this.build_certificate_base64,
      build_provision_profile_base64:
          build_provision_profile_base64 ?? this.build_provision_profile_base64,
      build_number: build_number ?? this.build_number,
      is_under_processing: is_under_processing ?? this.is_under_processing,
      status: status ?? this.status,
      pat: pat ?? this.pat,
      firebase_cli_token: firebase_cli_token ?? this.firebase_cli_token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': created_at,
      'branch': branch,
      'repository_url': repository_url,
      'build_certificate_base64': build_certificate_base64,
      'build_provision_profile_base64': build_provision_profile_base64,
      'build_number': build_number,
      'is_under_processing': is_under_processing,
      'status': status,
      'pat': pat,
      'firebase_cli_token': firebase_cli_token,
    };
  }

  factory BuildData.fromMap(Map<String, dynamic> map) {
    return BuildData(
      id: map['id'] as int,
      created_at: map['created_at'] as String,
      branch: map['branch'] as String,
      repository_url: map['repository_url'] as String,
      build_certificate_base64: map['build_certificate_base64'] as String,
      build_provision_profile_base64:
          map['build_provision_profile_base64'] as String,
      build_number: map['build_number'] as int,
      is_under_processing: map['is_under_processing'] as bool,
      status: map['status'] as bool,
      pat: map['pat'] as String,
      firebase_cli_token: map['firebase_cli_token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BuildData.fromJson(String source) =>
      BuildData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BuildData(id: $id, created_at: $created_at, branch: $branch, repository_url: $repository_url, build_certificate_base64: $build_certificate_base64, build_provision_profile_base64: $build_provision_profile_base64, build_number: $build_number, is_under_processing: $is_under_processing, status: $status, pat: $pat, firebase_cli_token: $firebase_cli_token)';
  }

  @override
  bool operator ==(covariant BuildData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.created_at == created_at &&
        other.branch == branch &&
        other.repository_url == repository_url &&
        other.build_certificate_base64 == build_certificate_base64 &&
        other.build_provision_profile_base64 ==
            build_provision_profile_base64 &&
        other.build_number == build_number &&
        other.is_under_processing == is_under_processing &&
        other.status == status &&
        other.pat == pat &&
        other.firebase_cli_token == firebase_cli_token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        created_at.hashCode ^
        branch.hashCode ^
        repository_url.hashCode ^
        build_certificate_base64.hashCode ^
        build_provision_profile_base64.hashCode ^
        build_number.hashCode ^
        is_under_processing.hashCode ^
        status.hashCode ^
        pat.hashCode ^
        firebase_cli_token.hashCode;
  }
}

///
//  Generated code. Do not modify.
//  source: project.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ProjectStatus extends $pb.ProtobufEnum {
  static const ProjectStatus PENDING = ProjectStatus._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PENDING');
  static const ProjectStatus ACTIVE = ProjectStatus._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ACTIVE');
  static const ProjectStatus INACTIVE = ProjectStatus._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INACTIVE');
  static const ProjectStatus COMPLETED = ProjectStatus._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COMPLETED');

  static const $core.List<ProjectStatus> values = <ProjectStatus> [
    PENDING,
    ACTIVE,
    INACTIVE,
    COMPLETED,
  ];

  static final $core.Map<$core.int, ProjectStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ProjectStatus? valueOf($core.int value) => _byValue[value];

  const ProjectStatus._($core.int v, $core.String n) : super(v, n);
}


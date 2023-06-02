///
//  Generated code. Do not modify.
//  source: project_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'project.pb.dart' as $6;
import 'package:protobuf_google/protobuf_google.dart' as $1;
import 'project_service.pb.dart' as $7;
export 'project_service.pb.dart';

class ProjectServiceClient extends $grpc.Client {
  static final _$projectCreated = $grpc.ClientMethod<$6.Project, $1.Empty>(
      '/crowdfunding.ProjectService/ProjectCreated',
      ($6.Project value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$projectUpdated = $grpc.ClientMethod<$6.Project, $1.Empty>(
      '/crowdfunding.ProjectService/ProjectUpdated',
      ($6.Project value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$userAddedToProject =
      $grpc.ClientMethod<$7.ProjectMember, $1.Empty>(
          '/crowdfunding.ProjectService/UserAddedToProject',
          ($7.ProjectMember value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  ProjectServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Empty> projectCreated($6.Project request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$projectCreated, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> projectUpdated($6.Project request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$projectUpdated, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> userAddedToProject($7.ProjectMember request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$userAddedToProject, request, options: options);
  }
}

abstract class ProjectServiceBase extends $grpc.Service {
  $core.String get $name => 'crowdfunding.ProjectService';

  ProjectServiceBase() {
    $addMethod($grpc.ServiceMethod<$6.Project, $1.Empty>(
        'ProjectCreated',
        projectCreated_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.Project.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$6.Project, $1.Empty>(
        'ProjectUpdated',
        projectUpdated_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $6.Project.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$7.ProjectMember, $1.Empty>(
        'UserAddedToProject',
        userAddedToProject_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $7.ProjectMember.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> projectCreated_Pre(
      $grpc.ServiceCall call, $async.Future<$6.Project> request) async {
    return projectCreated(call, await request);
  }

  $async.Future<$1.Empty> projectUpdated_Pre(
      $grpc.ServiceCall call, $async.Future<$6.Project> request) async {
    return projectUpdated(call, await request);
  }

  $async.Future<$1.Empty> userAddedToProject_Pre(
      $grpc.ServiceCall call, $async.Future<$7.ProjectMember> request) async {
    return userAddedToProject(call, await request);
  }

  $async.Future<$1.Empty> projectCreated(
      $grpc.ServiceCall call, $6.Project request);
  $async.Future<$1.Empty> projectUpdated(
      $grpc.ServiceCall call, $6.Project request);
  $async.Future<$1.Empty> userAddedToProject(
      $grpc.ServiceCall call, $7.ProjectMember request);
}

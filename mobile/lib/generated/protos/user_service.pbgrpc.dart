///
//  Generated code. Do not modify.
//  source: user_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'user_service.pb.dart' as $3;
import 'user.pb.dart' as $4;
import 'package:protobuf_google/protobuf_google.dart' as $5;
import 'package:protobuf_google/protobuf_google.dart' as $1;
export 'user_service.pb.dart';

class UserServiceClient extends $grpc.Client {
  static final _$createUser = $grpc.ClientMethod<$3.CreateUserRequest, $4.User>(
      '/crowdfunding.UserService/CreateUser',
      ($3.CreateUserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.User.fromBuffer(value));
  static final _$getUser = $grpc.ClientMethod<$5.StringValue, $4.User>(
      '/crowdfunding.UserService/GetUser',
      ($5.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.User.fromBuffer(value));
  static final _$getUserByEmail = $grpc.ClientMethod<$5.StringValue, $4.User>(
      '/crowdfunding.UserService/GetUserByEmail',
      ($5.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.User.fromBuffer(value));
  static final _$updateUser = $grpc.ClientMethod<$4.User, $4.User>(
      '/crowdfunding.UserService/UpdateUser',
      ($4.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $4.User.fromBuffer(value));
  static final _$deleteUser = $grpc.ClientMethod<$5.StringValue, $1.Empty>(
      '/crowdfunding.UserService/DeleteUser',
      ($5.StringValue value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$4.User> createUser($3.CreateUserRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createUser, request, options: options);
  }

  $grpc.ResponseFuture<$4.User> getUser($5.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUser, request, options: options);
  }

  $grpc.ResponseFuture<$4.User> getUserByEmail($5.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUserByEmail, request, options: options);
  }

  $grpc.ResponseFuture<$4.User> updateUser($4.User request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateUser, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> deleteUser($5.StringValue request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteUser, request, options: options);
  }
}

abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'crowdfunding.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$3.CreateUserRequest, $4.User>(
        'CreateUser',
        createUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $3.CreateUserRequest.fromBuffer(value),
        ($4.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.StringValue, $4.User>(
        'GetUser',
        getUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.StringValue.fromBuffer(value),
        ($4.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.StringValue, $4.User>(
        'GetUserByEmail',
        getUserByEmail_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.StringValue.fromBuffer(value),
        ($4.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$4.User, $4.User>(
        'UpdateUser',
        updateUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $4.User.fromBuffer(value),
        ($4.User value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$5.StringValue, $1.Empty>(
        'DeleteUser',
        deleteUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $5.StringValue.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$4.User> createUser_Pre($grpc.ServiceCall call,
      $async.Future<$3.CreateUserRequest> request) async {
    return createUser(call, await request);
  }

  $async.Future<$4.User> getUser_Pre(
      $grpc.ServiceCall call, $async.Future<$5.StringValue> request) async {
    return getUser(call, await request);
  }

  $async.Future<$4.User> getUserByEmail_Pre(
      $grpc.ServiceCall call, $async.Future<$5.StringValue> request) async {
    return getUserByEmail(call, await request);
  }

  $async.Future<$4.User> updateUser_Pre(
      $grpc.ServiceCall call, $async.Future<$4.User> request) async {
    return updateUser(call, await request);
  }

  $async.Future<$1.Empty> deleteUser_Pre(
      $grpc.ServiceCall call, $async.Future<$5.StringValue> request) async {
    return deleteUser(call, await request);
  }

  $async.Future<$4.User> createUser(
      $grpc.ServiceCall call, $3.CreateUserRequest request);
  $async.Future<$4.User> getUser(
      $grpc.ServiceCall call, $5.StringValue request);
  $async.Future<$4.User> getUserByEmail(
      $grpc.ServiceCall call, $5.StringValue request);
  $async.Future<$4.User> updateUser($grpc.ServiceCall call, $4.User request);
  $async.Future<$1.Empty> deleteUser(
      $grpc.ServiceCall call, $5.StringValue request);
}

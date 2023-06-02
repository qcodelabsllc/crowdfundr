///
//  Generated code. Do not modify.
//  source: donation_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'donation.pb.dart' as $0;
import 'package:protobuf_google/protobuf_google.dart' as $1;
import 'disbursement.pb.dart' as $2;
export 'donation_service.pb.dart';

class DonationServiceClient extends $grpc.Client {
  static final _$donationMade = $grpc.ClientMethod<$0.Donation, $1.Empty>(
      '/crowdfunding.DonationService/DonationMade',
      ($0.Donation value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));
  static final _$fundsDisbursed = $grpc.ClientMethod<$2.Disbursement, $1.Empty>(
      '/crowdfunding.DonationService/FundsDisbursed',
      ($2.Disbursement value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.Empty.fromBuffer(value));

  DonationServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.Empty> donationMade($0.Donation request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$donationMade, request, options: options);
  }

  $grpc.ResponseFuture<$1.Empty> fundsDisbursed($2.Disbursement request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fundsDisbursed, request, options: options);
  }
}

abstract class DonationServiceBase extends $grpc.Service {
  $core.String get $name => 'crowdfunding.DonationService';

  DonationServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Donation, $1.Empty>(
        'DonationMade',
        donationMade_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Donation.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$2.Disbursement, $1.Empty>(
        'FundsDisbursed',
        fundsDisbursed_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $2.Disbursement.fromBuffer(value),
        ($1.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$1.Empty> donationMade_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Donation> request) async {
    return donationMade(call, await request);
  }

  $async.Future<$1.Empty> fundsDisbursed_Pre(
      $grpc.ServiceCall call, $async.Future<$2.Disbursement> request) async {
    return fundsDisbursed(call, await request);
  }

  $async.Future<$1.Empty> donationMade(
      $grpc.ServiceCall call, $0.Donation request);
  $async.Future<$1.Empty> fundsDisbursed(
      $grpc.ServiceCall call, $2.Disbursement request);
}

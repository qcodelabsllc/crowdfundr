///
//  Generated code. Do not modify.
//  source: donation.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use donationDescriptor instead')
const Donation$json = const {
  '1': 'Donation',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'project_id', '3': 2, '4': 1, '5': 5, '10': 'projectId'},
    const {'1': 'user_id', '3': 3, '4': 1, '5': 5, '10': 'userId'},
    const {'1': 'amount', '3': 4, '4': 1, '5': 2, '10': 'amount'},
    const {'1': 'created_at', '3': 5, '4': 1, '5': 9, '10': 'createdAt'},
    const {'1': 'updated_at', '3': 6, '4': 1, '5': 9, '10': 'updatedAt'},
  ],
};

/// Descriptor for `Donation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List donationDescriptor = $convert.base64Decode('CghEb25hdGlvbhIOCgJpZBgBIAEoCVICaWQSHQoKcHJvamVjdF9pZBgCIAEoBVIJcHJvamVjdElkEhcKB3VzZXJfaWQYAyABKAVSBnVzZXJJZBIWCgZhbW91bnQYBCABKAJSBmFtb3VudBIdCgpjcmVhdGVkX2F0GAUgASgJUgljcmVhdGVkQXQSHQoKdXBkYXRlZF9hdBgGIAEoCVIJdXBkYXRlZEF0');

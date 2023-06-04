///
//  Generated code. Do not modify.
//  source: project.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use projectStatusDescriptor instead')
const ProjectStatus$json = const {
  '1': 'ProjectStatus',
  '2': const [
    const {'1': 'PENDING', '2': 0},
    const {'1': 'ACTIVE', '2': 1},
    const {'1': 'INACTIVE', '2': 2},
    const {'1': 'COMPLETED', '2': 3},
  ],
};

/// Descriptor for `ProjectStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List projectStatusDescriptor = $convert.base64Decode('Cg1Qcm9qZWN0U3RhdHVzEgsKB1BFTkRJTkcQABIKCgZBQ1RJVkUQARIMCghJTkFDVElWRRACEg0KCUNPTVBMRVRFRBAD');
@$core.Deprecated('Use projectDescriptor instead')
const Project$json = const {
  '1': 'Project',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'description', '3': 3, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'goal_amount', '3': 4, '4': 1, '5': 2, '10': 'goalAmount'},
    const {'1': 'amount_raised', '3': 5, '4': 1, '5': 2, '10': 'amountRaised'},
    const {'1': 'amount_disbursed', '3': 6, '4': 1, '5': 2, '10': 'amountDisbursed'},
    const {'1': 'status', '3': 7, '4': 1, '5': 14, '6': '.crowdfunding.ProjectStatus', '10': 'status'},
    const {'1': 'backers', '3': 8, '4': 1, '5': 5, '10': 'backers'},
    const {'1': 'project_owner', '3': 9, '4': 1, '5': 11, '6': '.crowdfunding.User', '10': 'projectOwner'},
    const {'1': 'created_at', '3': 10, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'createdAt'},
    const {'1': 'updated_at', '3': 11, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updatedAt'},
    const {'1': 'category_id', '3': 12, '4': 1, '5': 9, '10': 'categoryId'},
    const {'1': 'image_url', '3': 13, '4': 1, '5': 9, '9': 0, '10': 'imageUrl', '17': true},
    const {'1': 'start_date', '3': 14, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'startDate'},
    const {'1': 'end_date', '3': 15, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'endDate'},
  ],
  '8': const [
    const {'1': '_image_url'},
  ],
};

/// Descriptor for `Project`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List projectDescriptor = $convert.base64Decode('CgdQcm9qZWN0Eg4KAmlkGAEgASgJUgJpZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSIAoLZGVzY3JpcHRpb24YAyABKAlSC2Rlc2NyaXB0aW9uEh8KC2dvYWxfYW1vdW50GAQgASgCUgpnb2FsQW1vdW50EiMKDWFtb3VudF9yYWlzZWQYBSABKAJSDGFtb3VudFJhaXNlZBIpChBhbW91bnRfZGlzYnVyc2VkGAYgASgCUg9hbW91bnREaXNidXJzZWQSMwoGc3RhdHVzGAcgASgOMhsuY3Jvd2RmdW5kaW5nLlByb2plY3RTdGF0dXNSBnN0YXR1cxIYCgdiYWNrZXJzGAggASgFUgdiYWNrZXJzEjcKDXByb2plY3Rfb3duZXIYCSABKAsyEi5jcm93ZGZ1bmRpbmcuVXNlclIMcHJvamVjdE93bmVyEjkKCmNyZWF0ZWRfYXQYCiABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgljcmVhdGVkQXQSOQoKdXBkYXRlZF9hdBgLIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZWRBdBIfCgtjYXRlZ29yeV9pZBgMIAEoCVIKY2F0ZWdvcnlJZBIgCglpbWFnZV91cmwYDSABKAlIAFIIaW1hZ2VVcmyIAQESOQoKc3RhcnRfZGF0ZRgOIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXN0YXJ0RGF0ZRI1CghlbmRfZGF0ZRgPIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSB2VuZERhdGVCDAoKX2ltYWdlX3VybA==');

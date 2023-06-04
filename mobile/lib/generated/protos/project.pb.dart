///
//  Generated code. Do not modify.
//  source: project.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'user.pb.dart' as $0;
import 'package:protobuf_google/protobuf_google.dart' as $1;

import 'project.pbenum.dart';

export 'project.pbenum.dart';

class Project extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Project', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'crowdfunding'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..a<$core.double>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'goalAmount', $pb.PbFieldType.OF)
    ..a<$core.double>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountRaised', $pb.PbFieldType.OF)
    ..a<$core.double>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'amountDisbursed', $pb.PbFieldType.OF)
    ..e<ProjectStatus>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: ProjectStatus.PENDING, valueOf: ProjectStatus.valueOf, enumValues: ProjectStatus.values)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'backers', $pb.PbFieldType.O3)
    ..aOM<$0.User>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'projectOwner', subBuilder: $0.User.create)
    ..aOM<$1.Timestamp>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'createdAt', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updatedAt', subBuilder: $1.Timestamp.create)
    ..aOS(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'categoryId')
    ..aOS(13, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'imageUrl')
    ..aOM<$1.Timestamp>(14, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(15, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false
  ;

  Project._() : super();
  factory Project({
    $core.String? id,
    $core.String? title,
    $core.String? description,
    $core.double? goalAmount,
    $core.double? amountRaised,
    $core.double? amountDisbursed,
    ProjectStatus? status,
    $core.int? backers,
    $0.User? projectOwner,
    $1.Timestamp? createdAt,
    $1.Timestamp? updatedAt,
    $core.String? categoryId,
    $core.String? imageUrl,
    $1.Timestamp? startDate,
    $1.Timestamp? endDate,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (title != null) {
      _result.title = title;
    }
    if (description != null) {
      _result.description = description;
    }
    if (goalAmount != null) {
      _result.goalAmount = goalAmount;
    }
    if (amountRaised != null) {
      _result.amountRaised = amountRaised;
    }
    if (amountDisbursed != null) {
      _result.amountDisbursed = amountDisbursed;
    }
    if (status != null) {
      _result.status = status;
    }
    if (backers != null) {
      _result.backers = backers;
    }
    if (projectOwner != null) {
      _result.projectOwner = projectOwner;
    }
    if (createdAt != null) {
      _result.createdAt = createdAt;
    }
    if (updatedAt != null) {
      _result.updatedAt = updatedAt;
    }
    if (categoryId != null) {
      _result.categoryId = categoryId;
    }
    if (imageUrl != null) {
      _result.imageUrl = imageUrl;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory Project.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Project.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Project clone() => Project()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Project copyWith(void Function(Project) updates) => super.copyWith((message) => updates(message as Project)) as Project; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Project create() => Project._();
  Project createEmptyInstance() => create();
  static $pb.PbList<Project> createRepeated() => $pb.PbList<Project>();
  @$core.pragma('dart2js:noInline')
  static Project getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Project>(create);
  static Project? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get description => $_getSZ(2);
  @$pb.TagNumber(3)
  set description($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasDescription() => $_has(2);
  @$pb.TagNumber(3)
  void clearDescription() => clearField(3);

  @$pb.TagNumber(4)
  $core.double get goalAmount => $_getN(3);
  @$pb.TagNumber(4)
  set goalAmount($core.double v) { $_setFloat(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasGoalAmount() => $_has(3);
  @$pb.TagNumber(4)
  void clearGoalAmount() => clearField(4);

  @$pb.TagNumber(5)
  $core.double get amountRaised => $_getN(4);
  @$pb.TagNumber(5)
  set amountRaised($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAmountRaised() => $_has(4);
  @$pb.TagNumber(5)
  void clearAmountRaised() => clearField(5);

  @$pb.TagNumber(6)
  $core.double get amountDisbursed => $_getN(5);
  @$pb.TagNumber(6)
  set amountDisbursed($core.double v) { $_setFloat(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasAmountDisbursed() => $_has(5);
  @$pb.TagNumber(6)
  void clearAmountDisbursed() => clearField(6);

  @$pb.TagNumber(7)
  ProjectStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status(ProjectStatus v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.int get backers => $_getIZ(7);
  @$pb.TagNumber(8)
  set backers($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasBackers() => $_has(7);
  @$pb.TagNumber(8)
  void clearBackers() => clearField(8);

  @$pb.TagNumber(9)
  $0.User get projectOwner => $_getN(8);
  @$pb.TagNumber(9)
  set projectOwner($0.User v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasProjectOwner() => $_has(8);
  @$pb.TagNumber(9)
  void clearProjectOwner() => clearField(9);
  @$pb.TagNumber(9)
  $0.User ensureProjectOwner() => $_ensure(8);

  @$pb.TagNumber(10)
  $1.Timestamp get createdAt => $_getN(9);
  @$pb.TagNumber(10)
  set createdAt($1.Timestamp v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCreatedAt() => $_has(9);
  @$pb.TagNumber(10)
  void clearCreatedAt() => clearField(10);
  @$pb.TagNumber(10)
  $1.Timestamp ensureCreatedAt() => $_ensure(9);

  @$pb.TagNumber(11)
  $1.Timestamp get updatedAt => $_getN(10);
  @$pb.TagNumber(11)
  set updatedAt($1.Timestamp v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasUpdatedAt() => $_has(10);
  @$pb.TagNumber(11)
  void clearUpdatedAt() => clearField(11);
  @$pb.TagNumber(11)
  $1.Timestamp ensureUpdatedAt() => $_ensure(10);

  @$pb.TagNumber(12)
  $core.String get categoryId => $_getSZ(11);
  @$pb.TagNumber(12)
  set categoryId($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasCategoryId() => $_has(11);
  @$pb.TagNumber(12)
  void clearCategoryId() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get imageUrl => $_getSZ(12);
  @$pb.TagNumber(13)
  set imageUrl($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasImageUrl() => $_has(12);
  @$pb.TagNumber(13)
  void clearImageUrl() => clearField(13);

  @$pb.TagNumber(14)
  $1.Timestamp get startDate => $_getN(13);
  @$pb.TagNumber(14)
  set startDate($1.Timestamp v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasStartDate() => $_has(13);
  @$pb.TagNumber(14)
  void clearStartDate() => clearField(14);
  @$pb.TagNumber(14)
  $1.Timestamp ensureStartDate() => $_ensure(13);

  @$pb.TagNumber(15)
  $1.Timestamp get endDate => $_getN(14);
  @$pb.TagNumber(15)
  set endDate($1.Timestamp v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasEndDate() => $_has(14);
  @$pb.TagNumber(15)
  void clearEndDate() => clearField(15);
  @$pb.TagNumber(15)
  $1.Timestamp ensureEndDate() => $_ensure(14);
}


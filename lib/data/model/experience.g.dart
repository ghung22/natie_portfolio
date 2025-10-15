// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
  name: json['name'] as String?,
  nameVi: json['nameVi'] as String?,
  timeStart: json['timeStart'] == null ? null : DateTime.parse(json['timeStart'] as String),
  timeEnd: json['timeEnd'] == null ? null : DateTime.parse(json['timeEnd'] as String),
  major: json['major'] as String?,
  majorVi: json['majorVi'] as String?,
  imageUrls: (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList(),
  projectFilter: (json['projectFilter'] as List<dynamic>?)?.map((e) => $enumDecode(_$ProjectTagEnumMap, e)).toList(),
);

Map<String, dynamic> _$ExperienceToJson(Experience instance) => <String, dynamic>{
  'name': instance.name,
  'nameVi': instance.nameVi,
  'timeStart': instance.timeStart?.toIso8601String(),
  'timeEnd': instance.timeEnd?.toIso8601String(),
  'major': instance.major,
  'majorVi': instance.majorVi,
  'imageUrls': instance.imageUrls,
  'projectFilter': instance.projectFilter?.map((e) => _$ProjectTagEnumMap[e]!).toList(),
};

const _$ProjectTagEnumMap = {
  ProjectTag.mobile: 'mobile',
  ProjectTag.server: 'server',
  ProjectTag.game: 'game',
  ProjectTag.hcmus: 'hcmus',
  ProjectTag.indie: 'indie',
  ProjectTag.fpt: 'fpt',
  ProjectTag.teamobi: 'teamobi',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experience _$ExperienceFromJson(Map<String, dynamic> json) => Experience(
  name: json['name'] as String?,
  nameVi: json['nameVi'] as String?,
  time: json['time'] as String?,
  major: json['major'] as String?,
  majorVi: json['majorVi'] as String?,
  imageUrls: (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$ExperienceToJson(Experience instance) => <String, dynamic>{
  'name': instance.name,
  'nameVi': instance.nameVi,
  'time': instance.time,
  'major': instance.major,
  'majorVi': instance.majorVi,
  'imageUrls': instance.imageUrls,
};

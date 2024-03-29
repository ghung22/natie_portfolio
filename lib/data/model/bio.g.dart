// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bio _$BioFromJson(Map<String, dynamic> json) => Bio(
      title: json['title'] as String? ?? '',
      titleVi: json['titleVi'] as String? ?? '',
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      descriptionVi: json['descriptionVi'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String? ?? '',
      birthdayTimestamp: json['birthdayTimestamp'] as int? ?? 0,
      contact: (json['contact'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      colorHexes: (json['colorHexes'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [0x00000000],
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      scores: (json['scores'] as List<dynamic>?)
              ?.map((e) => Score.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      experience: (json['experience'] as List<dynamic>?)
              ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BioToJson(Bio instance) => <String, dynamic>{
      'title': instance.title,
      'titleVi': instance.titleVi,
      'name': instance.name,
      'description': instance.description,
      'descriptionVi': instance.descriptionVi,
      'avatarUrl': instance.avatarUrl,
      'birthdayTimestamp': instance.birthdayTimestamp,
      'contact': instance.contact,
      'colorHexes': instance.colorHexes,
      'imageUrls': instance.imageUrls,
      'scores': instance.scores.map((e) => e.toJson()).toList(),
      'experience': instance.experience.map((e) => e.toJson()).toList(),
    };

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
      colorHexes: (json['colorHexes'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [0x000000],
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      scores: (json['scores'] as List<dynamic>?)
              ?.map((e) => Score.fromJson(e as Map<String, dynamic>))
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
      'colorHexes': instance.colorHexes,
      'imageUrls': instance.imageUrls,
      'scores': instance.scores,
    };

Score _$ScoreFromJson(Map<String, dynamic> json) => Score(
      name: json['name'] as String? ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0,
      customData: json['customData'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
    );

Map<String, dynamic> _$ScoreToJson(Score instance) => <String, dynamic>{
      'name': instance.name,
      'score': instance.score,
      'customData': instance.customData,
    };

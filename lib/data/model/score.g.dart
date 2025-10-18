// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Score _$ScoreFromJson(Map<String, dynamic> json) => Score(
  name: json['name'] as String? ?? '',
  score: (json['score'] as num?)?.toDouble() ?? 0,
  scoreMax: (json['scoreMax'] as num?)?.toDouble() ?? 0,
  customData:
      json['customData'] as Map<String, dynamic>? ?? const <String, dynamic>{},
);

Map<String, dynamic> _$ScoreToJson(Score instance) => <String, dynamic>{
  'name': instance.name,
  'score': instance.score,
  'scoreMax': instance.scoreMax,
  'customData': instance.customData,
};

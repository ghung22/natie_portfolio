// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countable_double.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountableDouble _$CountableDoubleFromJson(Map<String, dynamic> json) =>
    CountableDouble(
      (json['value'] as num).toDouble(),
      fractionalLength: (json['fractionalLength'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CountableDoubleToJson(CountableDouble instance) =>
    <String, dynamic>{
      'value': instance.value,
      'fractionalLength': instance.fractionalLength,
    };

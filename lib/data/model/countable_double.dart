import 'dart:math';

import 'package:json_annotation/json_annotation.dart';

part 'countable_double.g.dart';

@JsonSerializable()
class CountableDouble {
  final double value;
  final int fractionalLength;

  CountableDouble(this.value, {int? fractionalLength})
    : fractionalLength = fractionalLength ?? '$value.'.split('.')[1].length.clamp(0, 3);

  int get countValue {
    var v = value;
    for (var i = 0; i < fractionalLength; i++) {
      v *= 10;
      if ('$v.'.split('.')[1].isEmpty) break;
    }
    return v.floor();
  }

  String parseCurrentValue(int v) {
    double val = v / pow(10, fractionalLength);
    final doubleStrings = '$val.'.split('.');
    if (doubleStrings[1].isEmpty) return doubleStrings[0];
    return '${doubleStrings[0]}.${doubleStrings[1].padRight(fractionalLength, '0')}';
  }

  double operator +(double other) => value + other;

  double operator -(double other) => value - other;

  double operator *(double other) => value * other;

  double operator /(double other) => value / other;

  double operator %(double other) => value % other;

  CountableDouble operator -() => CountableDouble(-value);

  factory CountableDouble.fromJson(Map<String, dynamic> json) => _$CountableDoubleFromJson(json);

  Map<String, dynamic> toJson() => _$CountableDoubleToJson(this);

  @override
  String toString() => value.toString();
}

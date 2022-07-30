import 'package:json_annotation/json_annotation.dart';

part 'score.g.dart';

@JsonSerializable()
class Score {
  final String name;
  final double score;
  final Map<String, dynamic> customData;

  const Score({
    this.name = '',
    this.score = 0,
    this.customData = const <String, dynamic>{},
  });

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);

  Map<String, dynamic> toJson() => _$ScoreToJson(this);

  @override
  String toString() => toJson().toString();
}
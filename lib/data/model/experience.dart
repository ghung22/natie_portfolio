import 'package:json_annotation/json_annotation.dart';
import 'package:natie_portfolio/data/model/project.dart';

part 'experience.g.dart';

@JsonSerializable()
class Experience {
  final String? name;
  final String? nameVi;
  final String? time;
  final String? major;
  final String? majorVi;
  final List<String>? imageUrls;
  final List<ProjectTag>? projectFilter;

  const Experience({this.name, this.nameVi, this.time, this.major, this.majorVi, this.imageUrls, this.projectFilter});

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);

  @override
  String toString() => toJson().toString();
}

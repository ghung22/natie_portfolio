import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

@JsonSerializable()
class Experience {
  final String? name;
  final String? nameVi;
  final String? time;
  final String? major;
  final String? majorVi;
  final List<String>? imageUrls;

  const Experience({this.name, this.nameVi, this.time, this.major, this.majorVi, this.imageUrls});

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);

  @override
  String toString() => toJson().toString();
}

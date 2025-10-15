import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:natie_portfolio/data/model/project.dart';
import 'package:natie_portfolio/l10n/app_localizations.dart';

part 'experience.g.dart';

@JsonSerializable()
class Experience {
  final String? name;
  final String? nameVi;
  final DateTime? timeStart;
  final DateTime? timeEnd;
  final String? major;
  final String? majorVi;
  final List<String>? imageUrls;
  final List<ProjectTag>? projectFilter;

  String? get _timeStartStr => timeStart != null ? DateFormat.yM().format(timeStart!) : null;

  String? get _timeEndStr => timeEnd != null ? DateFormat.yM().format(timeEnd!) : null;

  String? getTimeRangeStr(BuildContext context) {
    if (timeStart != null && timeEnd != null) {
      return '$_timeStartStr - $_timeEndStr';
    }
    if (timeStart?.isBefore(DateTime.now()) ?? false) {
      return '$_timeStartStr - ${AppLocalizations.of(context)!.now}';
    }
    return _timeStartStr ?? _timeEndStr;
  }

  const Experience({
    this.name,
    this.nameVi,
    this.timeStart,
    this.timeEnd,
    this.major,
    this.majorVi,
    this.imageUrls,
    this.projectFilter,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);

  @override
  String toString() => toJson().toString();
}

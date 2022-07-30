import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bio.g.dart';

/// --------------------------------------------------------------------------
/// **A model to represent projects that I've made**
///
/// **Parameters:**
/// * [title]             : My target position
/// * [name]              : My full name
/// * [description]       : WWho am I
/// * [avatarUrl]         : My avatar picture
/// * [birthdayTimestamp] : The timestamp of my birthday
/// * [colorHexes]        : Colors representing my style
/// * [imageUrls]         : More photos of me in real life
/// * [scores]            : A list of certificates and skills
///
/// **Getters:**
/// * [colors]            : Convert [colorHexes]'s value to [Color]
/// * [birthday]          : Convert [birthdayTimestamp] to [DateTime]
/// --------------------------------------------------------------------------
@JsonSerializable()
class Bio {
  final String title;
  final String titleVi;
  final String name;
  final String description;
  final String descriptionVi;
  final String avatarUrl;
  final int birthdayTimestamp;
  final List<int> colorHexes;
  final List<String> imageUrls;
  final List<Score> scores;

  const Bio({
    this.title = '',
    this.titleVi = '',
    this.name = '',
    this.description = '',
    this.descriptionVi = '',
    this.avatarUrl = '',
    this.birthdayTimestamp = 0,
    this.colorHexes = const [0x000000],
    this.imageUrls = const [],
    this.scores = const [],
  });

  List<Color> get colors => colorHexes.map((c) => Color(c)).toList();

  DateTime get birthday =>
      DateTime.fromMillisecondsSinceEpoch(birthdayTimestamp);

  factory Bio.fromJson(Map<String, dynamic> json) => _$BioFromJson(json);

  Map<String, dynamic> toJson() => _$BioToJson(this);

  @override
  String toString() => toJson().toString();
}

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

class BioData {
  static Bio value = Bio(
    title: 'Gia Hưng - Mobile Developer',
    titleVi: 'Gia Hưng - Lập trình viên di động',
    name: 'Nguyễn Gia Hưng',
    description:
        'An aspiring mobile developer who is passionate about building apps for the modern world, with a focus on UX/UI.',
    descriptionVi:
        'Một lập trình viên di động đầy tham vọng với niềm đam mê trong việc xây dựng các ứng dụng di động hiện đại, tập trung vào tối ưu UX/UI.',
    avatarUrl: '',
    birthdayTimestamp: DateTime(2000, 01, 02).millisecondsSinceEpoch,
    colorHexes: const [0x00B294],
    imageUrls: const [],
    scores: const [
      Score(name: 'GPA', score: 3.19),
      Score(name: 'TOEIC', score: 950),
      Score(name: 'TOEIC S&W', score: 360),
    ],
  );
}
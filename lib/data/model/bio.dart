import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:natie_portfolio/data/model/experience.dart';
import 'package:natie_portfolio/data/model/project.dart';

import 'score.dart';

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
/// * [contact]           : My contact information
/// * [colorHexes]        : Colors representing my style
/// * [imageUrls]         : More photos of me in real life
/// * [scores]            : A list of certificates and skills
/// * [experience]        : A list of past education and work experiences
///
/// **Getters:**
/// * [colors]            : Convert [colorHexes]'s value to [Color]
/// * [birthday]          : Convert [birthdayTimestamp] to [DateTime]
/// --------------------------------------------------------------------------
@JsonSerializable(explicitToJson: true)
class Bio {
  final String title;
  final String titleVi;
  final String name;
  final String description;
  final String descriptionVi;
  final String avatarUrl;
  final int birthdayTimestamp;
  final Map<String, String> contact;
  final List<int> colorHexes;
  final List<String> imageUrls;
  final List<Score> scores;
  final List<Experience> experience;

  const Bio({
    this.title = '',
    this.titleVi = '',
    this.name = '',
    this.description = '',
    this.descriptionVi = '',
    this.avatarUrl = '',
    this.birthdayTimestamp = 0,
    this.contact = const {},
    this.colorHexes = const [0x00000000],
    this.imageUrls = const [],
    this.scores = const [],
    this.experience = const [],
  });

  bool get isEmpty => this == const Bio();

  bool get isNotEmpty => !isEmpty;

  List<Color> get colors => colorHexes.map((c) => Color(c)).toList();

  DateTime get birthday => DateTime.fromMillisecondsSinceEpoch(birthdayTimestamp);

  factory Bio.fromJson(Map<String, dynamic> json) => _$BioFromJson(json);

  Map<String, dynamic> toJson() => _$BioToJson(this);

  @override
  String toString() => toJson().toString();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bio &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          titleVi == other.titleVi &&
          name == other.name &&
          description == other.description &&
          descriptionVi == other.descriptionVi &&
          avatarUrl == other.avatarUrl &&
          birthdayTimestamp == other.birthdayTimestamp &&
          colorHexes == other.colorHexes &&
          imageUrls == other.imageUrls &&
          scores == other.scores;

  @override
  int get hashCode =>
      title.hashCode ^
      titleVi.hashCode ^
      name.hashCode ^
      description.hashCode ^
      descriptionVi.hashCode ^
      avatarUrl.hashCode ^
      birthdayTimestamp.hashCode ^
      colorHexes.hashCode ^
      imageUrls.hashCode ^
      scores.hashCode;
}

class BioData {
  static Bio value = Bio(
    title: 'Gia Hưng - Software Developer',
    titleVi: 'Gia Hưng - Lập trình viên',
    name: 'Nguyễn Gia Hưng',
    description:
        'An aspiring mobile developer who is passionate about building apps for the modern world, with a focus on UX/UI.',
    descriptionVi:
        'Một lập trình viên di động đầy tham vọng với niềm đam mê trong việc xây dựng các ứng dụng di động hiện đại, tập trung vào tối ưu UX/UI.',
    contact: {'GitHub': 'https://github.com/ghung22', 'Gmail': 'mailto:ghung22.fortune@gmail.com'},
    avatarUrl: 'https://i.imgur.com/LCOYr8O.jpeg',
    birthdayTimestamp: DateTime(2000, 01, 02).millisecondsSinceEpoch,
    colorHexes: const [0x00B294],
    imageUrls: const [],
    scores: const [
      Score(name: 'GPA', score: 3.19, scoreMax: 4),
      Score(name: 'TOEIC', score: 950, scoreMax: 990),
      Score(name: 'TOEIC S&W', score: 360, scoreMax: 400),
    ],
    experience: [hcmus, fpt, teamobi],
  );

  static Experience hcmus = Experience(
    name: 'Ho Chi Minh University of Science',
    nameVi: 'Trường đại học Khoa học tự nhiên TP.HCM',
    timeStart: DateTime(2018),
    timeEnd: DateTime(2022),
    major: 'Computer Science - Software Engineering',
    majorVi: 'Công nghệ thông tin - Kỹ thuật phần mềm',
    imageUrls: ['https://i.imgur.com/6llAwcc.png', 'https://i.imgur.com/nqcutY6.jpg'],
    projectFilter: [ProjectTag.hcmus],
  );

  static Experience fpt = Experience(
    name: 'FPT Software',
    nameVi: 'Công ty TNHH Phần mềm FPT',
    timeStart: DateTime(2021, 6),
    timeEnd: DateTime(2021, 9),
    major: 'Mobile Developer Intern',
    majorVi: 'Thực tập viên Lập trình viên di động',
    imageUrls: ['https://i.imgur.com/QGBdFR0.png', 'https://i.imgur.com/FxV61QJ.png'],
    projectFilter: [ProjectTag.fpt],
  );

  static Experience teamobi = Experience(
    name: 'TeaMobi',
    nameVi: 'Công ty TNHH TeaMobi',
    timeStart: DateTime(2022, 10),
    timeEnd: DateTime(2026, 2),
    major: 'Fullstack Junior Developer',
    majorVi: 'Lập trình viên Fullstack Junior',
    imageUrls: ['http://gomobi.vn/home/app/view/images/logo.png'],
    projectFilter: [ProjectTag.teamobi],
  );
}

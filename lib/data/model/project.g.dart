// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
  id: json['id'] as String? ?? '',
  title: json['title'] as String? ?? '',
  titleVi: json['titleVi'] as String? ?? '',
  author: json['author'] as String? ?? '',
  authorVi: json['authorVi'] as String? ?? '',
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => $enumDecode(_$ProjectTagEnumMap, e)).toList() ??
      const <ProjectTag>[],
  tech: json['tech'] as String? ?? '',
  description: json['description'] as String? ?? '',
  descriptionVi: json['descriptionVi'] as String? ?? '',
  functionalities: (json['functionalities'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const <String>[],
  functionalitiesVi:
      (json['functionalitiesVi'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const <String>[],
  learned: (json['learned'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const <String>[],
  learnedVi: (json['learnedVi'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const <String>[],
  hostUrl: json['hostUrl'] as String? ?? '',
  iconUrl: json['iconUrl'] as String? ?? '',
  imageUrls:
      (json['imageUrls'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[
        'https://static.vecteezy.com/system/resources/previews/008/520/175/original/hand-holding-smartphone-with-screen-mockup-png.png',
      ],
  colorHex: (json['colorHex'] as num?)?.toInt() ?? 0x000000,
  completionTimestamp: (json['completionTimestamp'] as num?)?.toInt(),
  featured: json['featured'] as bool? ?? false,
);

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'titleVi': instance.titleVi,
  'author': instance.author,
  'authorVi': instance.authorVi,
  'tags': instance.tags.map((e) => _$ProjectTagEnumMap[e]!).toList(),
  'tech': instance.tech,
  'description': instance.description,
  'descriptionVi': instance.descriptionVi,
  'functionalities': instance.functionalities,
  'functionalitiesVi': instance.functionalitiesVi,
  'learned': instance.learned,
  'learnedVi': instance.learnedVi,
  'hostUrl': instance.hostUrl,
  'iconUrl': instance.iconUrl,
  'imageUrls': instance.imageUrls,
  'colorHex': instance.colorHex,
  'completionTimestamp': instance.completionTimestamp,
  'featured': instance.featured,
};

const _$ProjectTagEnumMap = {
  ProjectTag.mobile: 'mobile',
  ProjectTag.server: 'server',
  ProjectTag.game: 'game',
  ProjectTag.hcmus: 'hcmus',
  ProjectTag.indie: 'indie',
  ProjectTag.fpt: 'fpt',
  ProjectTag.teamobi: 'teamobi',
};

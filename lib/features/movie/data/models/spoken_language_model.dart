import 'dart:convert';

import 'package:moviki/features/movie/domain/entities/spoken_language.dart';

class SpokenLanguageModel extends SpokenLanguageEntity {
  const SpokenLanguageModel(
      {String? englishName, String? iso6391, String? name})
      : super(
          englishName: englishName,
          iso6391: iso6391,
          name: name,
        );

  factory SpokenLanguageModel.fromMap(Map<String, dynamic> map) {
    return SpokenLanguageModel(
      englishName:
          map['englishName'] != null ? map['englishName'] as String : null,
      iso6391: map['iso6391'] != null ? map['iso6391'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  factory SpokenLanguageModel.fromJson(String source) =>
      SpokenLanguageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory SpokenLanguageModel.fromEntity(SpokenLanguageEntity entity) {
    return SpokenLanguageModel(
      englishName: entity.englishName,
      iso6391: entity.iso6391,
      name: entity.name,
    );
  }
}

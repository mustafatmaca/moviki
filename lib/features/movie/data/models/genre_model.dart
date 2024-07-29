import 'dart:convert';

import 'package:moviki/features/movie/domain/entities/genre.dart';

class GenreModel extends GenreEntity {
  const GenreModel({int? id, String? name})
      : super(
          id: id,
          name: name,
        );

  factory GenreModel.fromMap(Map<String, dynamic> map) {
    return GenreModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  factory GenreModel.fromJson(String source) =>
      GenreModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory GenreModel.fromEntity(GenreEntity entity) {
    return GenreModel(
      id: entity.id,
      name: entity.name,
    );
  }
}

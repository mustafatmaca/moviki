import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:moviki/features/movie/data/models/genre_model.dart';
import 'package:moviki/features/movie/data/models/spoken_language_model.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

@Entity(tableName: 'movie', primaryKeys: ['id'])
class MovieModel extends MovieEntity {
  const MovieModel({
    int? id,
    bool? adult,
    String? backdropPath,
    int? budget,
    @ignore List<GenreModel>? genres,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? releaseDate,
    int? revenue,
    int? runtime,
    @ignore List<SpokenLanguageModel>? spokenLanguages,
    String? status,
    String? tagline,
    String? title,
    bool? video,
    double? voteAverage,
    int? voteCount,
  }) : super(
            id: id,
            adult: adult,
            backdropPath: backdropPath,
            budget: budget,
            genres: genres,
            originalLanguage: originalLanguage,
            originalTitle: originalTitle,
            overview: overview,
            popularity: popularity,
            posterPath: posterPath,
            releaseDate: releaseDate,
            revenue: revenue,
            runtime: runtime,
            spokenLanguages: spokenLanguages,
            status: status,
            tagline: tagline,
            title: title,
            video: video,
            voteAverage: voteAverage,
            voteCount: voteCount);

  factory MovieModel.fromMap(Map<String, dynamic> map) {
    return MovieModel(
      id: map['id'] != null ? map['id'] as int : null,
      adult: map['adult'] != null ? map['adult'] as bool : null,
      backdropPath:
          map['backdrop_path'] != null ? map['backdrop_path'] as String : null,
      budget: map['budget'] != null ? map['budget'] as int : null,
      genres: map['genres'] != null
          ? List<GenreModel>.from(
              (map['genres'] as List<Map<String, dynamic>>).map<GenreModel?>(
                (x) => GenreModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      originalLanguage: map['original_language'] != null
          ? map['original_language'] as String
          : null,
      originalTitle: map['original_title'] != null
          ? map['original_title'] as String
          : null,
      overview: map['overview'] != null ? map['overview'] as String : null,
      popularity:
          map['popularity'] != null ? map['popularity'] as double : null,
      posterPath:
          map['poster_path'] != null ? map['poster_path'] as String : null,
      releaseDate:
          map['release_date'] != null ? map['release_date'] as String : null,
      revenue: map['revenue'] != null ? map['revenue'] as int : null,
      runtime: map['runtime'] != null ? map['runtime'] as int : null,
      spokenLanguages: map['spoken_languages'] != null
          ? List<SpokenLanguageModel>.from(
              (map['spoken_languages'] as List<Map<String, dynamic>>)
                  .map<SpokenLanguageModel?>(
                (x) => SpokenLanguageModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      tagline: map['tagline'] != null ? map['tagline'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      video: map['video'] != null ? map['video'] as bool : null,
      voteAverage:
          map['vote_average'] != null ? map['vote_average'] as double : null,
      voteCount: map['vote_count'] != null ? map['vote_count'] as int : null,
    );
  }

  factory MovieModel.fromJson(String source) =>
      MovieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory MovieModel.fromEntity(MovieEntity entity) {
    return MovieModel(
      id: entity.id,
      adult: entity.adult,
      backdropPath: entity.backdropPath,
      budget: entity.budget,
      genres: entity.genres != null
          ? List<GenreModel>.from(
              entity.genres!.map((x) => GenreModel.fromEntity(x)))
          : null,
      originalLanguage: entity.originalLanguage,
      originalTitle: entity.originalTitle,
      overview: entity.overview,
      popularity: entity.popularity,
      posterPath: entity.posterPath,
      releaseDate: entity.releaseDate,
      revenue: entity.revenue,
      runtime: entity.runtime,
      spokenLanguages: entity.spokenLanguages != null
          ? List<SpokenLanguageModel>.from(entity.spokenLanguages!
              .map((x) => SpokenLanguageModel.fromEntity(x)))
          : null,
      status: entity.status,
      tagline: entity.tagline,
      title: entity.title,
      video: entity.video,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
    );
  }
}

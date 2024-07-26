import 'package:equatable/equatable.dart';
import 'package:moviki/features/movie/domain/entities/genre.dart';
import 'package:moviki/features/movie/domain/entities/spoken_language.dart';

class MovieEntity extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final int? budget;
  final List<GenreEntity>? genres;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguageEntity>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  MovieEntity(
      {this.id,
      this.adult,
      this.backdropPath,
      this.budget,
      this.genres,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  @override
  List<Object?> get props {
    return [
      id,
      adult,
      backdropPath,
      budget,
      genres,
      originalLanguage,
      originalTitle,
      overview,
      popularity,
      posterPath,
      releaseDate,
      revenue,
      runtime,
      spokenLanguages,
      status,
      tagline,
      title,
      video,
      voteAverage,
      voteCount
    ];
  }
}

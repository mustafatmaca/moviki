import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

abstract class SimilarMoviesState extends Equatable {
  final List<MovieEntity>? movies;
  final DioException? error;

  const SimilarMoviesState({this.movies, this.error});

  @override
  List<Object> get props => [movies!, error!];
}

final class SimilarMoviesInitial extends SimilarMoviesState {
  const SimilarMoviesInitial();
}

final class SimilarMoviesLoading extends SimilarMoviesState {
  const SimilarMoviesLoading();
}

final class SimilarMoviesLoaded extends SimilarMoviesState {
  const SimilarMoviesLoaded(List<MovieEntity> movies) : super(movies: movies);

  @override
  List<Object> get props => [movies!];
}

final class SimilarMoviesError extends SimilarMoviesState {
  const SimilarMoviesError(DioException error) : super(error: error);
}

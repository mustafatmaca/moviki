import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

abstract class SearchMovieState extends Equatable {
  final List<MovieEntity>? movies;
  final DioException? error;

  const SearchMovieState({this.movies, this.error});

  @override
  List<Object> get props => [movies!, error!];
}

final class SearchMovieInitial extends SearchMovieState {
  const SearchMovieInitial();
}

final class SearchMovieLoading extends SearchMovieState {
  const SearchMovieLoading();
}

final class SearchMovieLoaded extends SearchMovieState {
  const SearchMovieLoaded(List<MovieEntity> movies) : super(movies: movies);

  @override
  List<Object> get props => [movies!];
}

final class SearchMovieError extends SearchMovieState {
  const SearchMovieError(DioException error) : super(error: error);

  @override
  List<Object> get props => [error!];
}

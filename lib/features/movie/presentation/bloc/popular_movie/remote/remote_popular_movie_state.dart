import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

abstract class RemotePopularMovieState extends Equatable {
  final List<MovieEntity>? movies;
  final DioException? error;

  const RemotePopularMovieState({this.movies, this.error});

  @override
  List<Object> get props => [movies!, error!];
}

final class RemotePopularMovieInitial extends RemotePopularMovieState {
  const RemotePopularMovieInitial();
}

final class RemotePopularMovieLoading extends RemotePopularMovieState {
  const RemotePopularMovieLoading();
}

final class RemotePopularMovieLoaded extends RemotePopularMovieState {
  const RemotePopularMovieLoaded(List<MovieEntity> movies)
      : super(movies: movies);
}

final class RemotePopularMovieError extends RemotePopularMovieState {
  const RemotePopularMovieError(DioException error) : super(error: error);
}

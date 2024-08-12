import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

abstract class RemoteTopMovieState extends Equatable {
  final List<MovieEntity>? movies;
  final DioException? error;

  const RemoteTopMovieState({this.movies, this.error});

  @override
  List<Object> get props => [movies!, error!];
}

final class RemoteTopMovieInitial extends RemoteTopMovieState {
  const RemoteTopMovieInitial();
}

final class RemoteTopMovieLoading extends RemoteTopMovieState {
  const RemoteTopMovieLoading();
}

final class RemoteTopMovieLoaded extends RemoteTopMovieState {
  const RemoteTopMovieLoaded(List<MovieEntity> movies) : super(movies: movies);
}

final class RemoteTopMovieError extends RemoteTopMovieState {
  const RemoteTopMovieError(DioException error) : super(error: error);
}

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

abstract class RemoteMovieState extends Equatable {
  final List<MovieEntity>? movies;
  final DioException? error;

  const RemoteMovieState({this.movies, this.error});

  @override
  List<Object> get props => [movies!, error!];
}

final class RemoteMovieInitial extends RemoteMovieState {
  const RemoteMovieInitial();
}

final class RemoteMovieLoading extends RemoteMovieState {
  const RemoteMovieLoading();
}

final class RemoteMovieLoaded extends RemoteMovieState {
  const RemoteMovieLoaded(List<MovieEntity> movies) : super(movies: movies);
}

final class RemoteMovieError extends RemoteMovieState {
  const RemoteMovieError(DioException error) : super(error: error);
}

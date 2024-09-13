import 'package:equatable/equatable.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

abstract class FavoriteMovieState extends Equatable {
  final List<MovieEntity>? movies;

  const FavoriteMovieState({this.movies});

  @override
  List<Object> get props => [movies!];
}

final class FavoriteMovieInitial extends FavoriteMovieState {
  const FavoriteMovieInitial();
}

final class FavoriteMovieLoading extends FavoriteMovieState {
  const FavoriteMovieLoading();
}

final class FavoriteMovieLoaded extends FavoriteMovieState {
  const FavoriteMovieLoaded(List<MovieEntity> movies) : super(movies: movies);

  @override
  List<Object> get props => [movies!];
}

final class FavoriteMovieError extends FavoriteMovieState {
  const FavoriteMovieError();
}

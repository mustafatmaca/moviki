import 'package:equatable/equatable.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

abstract class FavoriteMovieEvent extends Equatable {
  final MovieEntity? movie;

  const FavoriteMovieEvent({this.movie});

  @override
  List<Object> get props => [movie!];
}

class GetFavoriteMovies extends FavoriteMovieEvent {
  const GetFavoriteMovies();
}

class SaveMovie extends FavoriteMovieEvent {
  const SaveMovie(MovieEntity movie) : super(movie: movie);

  @override
  List<Object> get props => [movie!];
}

class RemoveMovie extends FavoriteMovieEvent {
  const RemoveMovie(MovieEntity movie) : super(movie: movie);

  @override
  List<Object> get props => [movie!];
}

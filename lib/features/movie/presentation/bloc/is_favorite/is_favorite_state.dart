import 'package:equatable/equatable.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

abstract class IsFavoriteState extends Equatable {
  final MovieEntity? movie;

  const IsFavoriteState({this.movie});

  @override
  List<Object> get props => [movie!];
}

final class IsFavoriteInitial extends IsFavoriteState {
  const IsFavoriteInitial();
}

final class IsFavoriteLoading extends IsFavoriteState {
  const IsFavoriteLoading();
}

final class IsFavoriteLoaded extends IsFavoriteState {
  const IsFavoriteLoaded(MovieEntity movie) : super(movie: movie);

  @override
  List<Object> get props => [movie!];
}

final class IsFavoriteError extends IsFavoriteState {
  const IsFavoriteError();
}

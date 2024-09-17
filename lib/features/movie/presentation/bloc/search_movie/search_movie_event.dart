import 'package:equatable/equatable.dart';

abstract class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object> get props => [];
}

class SearchMovies extends SearchMovieEvent {
  final String? query;

  const SearchMovies({this.query});

  @override
  List<Object> get props => [query!];
}

import 'package:equatable/equatable.dart';

abstract class RemotePopularMovieEvent extends Equatable {
  const RemotePopularMovieEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMovies extends RemotePopularMovieEvent {
  const GetPopularMovies();
}

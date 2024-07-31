import 'package:equatable/equatable.dart';

abstract class RemoteMovieEvent extends Equatable {
  const RemoteMovieEvent();

  @override
  List<Object> get props => [];
}

class GetPopularMovies extends RemoteMovieEvent {
  const GetPopularMovies();
}

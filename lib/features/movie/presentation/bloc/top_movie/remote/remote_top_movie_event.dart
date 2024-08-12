import 'package:equatable/equatable.dart';

abstract class RemoteTopMovieEvent extends Equatable {
  const RemoteTopMovieEvent();

  @override
  List<Object> get props => [];
}

class GetTopRatedMovies extends RemoteTopMovieEvent {
  const GetTopRatedMovies();
}

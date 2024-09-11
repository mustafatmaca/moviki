import 'package:equatable/equatable.dart';

abstract class MovieRuntimeEvent extends Equatable {
  const MovieRuntimeEvent();

  @override
  List<Object> get props => [];
}

class GetRuntime extends MovieRuntimeEvent {
  final int? movieId;

  const GetRuntime({this.movieId});

  @override
  List<Object> get props => [movieId!];
}

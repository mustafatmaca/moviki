import 'package:equatable/equatable.dart';

abstract class SimilarMoviesEvent extends Equatable {
  const SimilarMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetSimilarMovies extends SimilarMoviesEvent {
  final int? id;

  const GetSimilarMovies({this.id});

  @override
  List<Object> get props => [id!];
}

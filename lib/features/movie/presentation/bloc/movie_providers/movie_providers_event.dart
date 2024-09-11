import 'package:equatable/equatable.dart';

abstract class MovieProvidersEvent extends Equatable {
  const MovieProvidersEvent();

  @override
  List<Object> get props => [];
}

class GetMovieProviders extends MovieProvidersEvent {
  final int? id;

  const GetMovieProviders({this.id});

  @override
  List<Object> get props => [id!];
}

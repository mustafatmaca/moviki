import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:moviki/features/movie/domain/entities/movie_provider.dart';

abstract class MovieProvidersState extends Equatable {
  final List<MovieProviderEntity>? movieProviders;
  final DioException? error;

  const MovieProvidersState({this.movieProviders, this.error});

  @override
  List<Object> get props => [movieProviders!, error!];
}

final class MovieProvidersInitial extends MovieProvidersState {
  const MovieProvidersInitial();
}

final class MovieProvidersLoading extends MovieProvidersState {
  const MovieProvidersLoading();
}

final class MovieProvidersLoaded extends MovieProvidersState {
  const MovieProvidersLoaded(List<MovieProviderEntity> movieProviders)
      : super(movieProviders: movieProviders);
}

final class MovieProvidersError extends MovieProvidersState {
  const MovieProvidersError(DioException error) : super(error: error);
}

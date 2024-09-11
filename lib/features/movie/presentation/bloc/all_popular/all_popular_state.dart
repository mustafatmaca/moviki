import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

abstract class AllPopularState extends Equatable {
  final List<MovieEntity>? movies;
  final DioException? error;

  const AllPopularState({this.movies, this.error});

  @override
  List<Object> get props => [movies!, error!];
}

final class AllPopularInitial extends AllPopularState {
  const AllPopularInitial();
}

final class AllPopularLoading extends AllPopularState {
  const AllPopularLoading();
}

final class AllPopularLoaded extends AllPopularState {
  const AllPopularLoaded(List<MovieEntity> movies) : super(movies: movies);

  @override
  List<Object> get props => [movies!];
}

final class AllPopularError extends AllPopularState {
  const AllPopularError(DioException error) : super(error: error);
}

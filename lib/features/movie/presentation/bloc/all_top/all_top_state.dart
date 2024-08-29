import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

abstract class AllTopState extends Equatable {
  final List<MovieEntity>? movies;
  final DioException? error;

  const AllTopState({this.movies, this.error});

  @override
  List<Object> get props => [movies!, error!];
}

final class AllTopInitial extends AllTopState {
  const AllTopInitial();
}

final class AllTopLoading extends AllTopState {
  const AllTopLoading();
}

final class AllTopLoaded extends AllTopState {
  const AllTopLoaded(List<MovieEntity> movies) : super(movies: movies);
}

final class AllTopError extends AllTopState {
  const AllTopError(DioException error) : super(error: error);
}

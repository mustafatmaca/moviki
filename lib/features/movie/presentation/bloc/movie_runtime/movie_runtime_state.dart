import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class MovieRuntimeState extends Equatable {
  final int? runtime;
  final DioException? error;
  const MovieRuntimeState({this.runtime, this.error});

  @override
  List<Object> get props => [runtime!, error!];
}

final class MovieRuntimeInitial extends MovieRuntimeState {
  const MovieRuntimeInitial();
}

final class MovieRuntimeLoading extends MovieRuntimeState {
  const MovieRuntimeLoading();
}

final class MovieRuntimeLoaded extends MovieRuntimeState {
  const MovieRuntimeLoaded(int runtime) : super(runtime: runtime);
}

final class MovieRuntimeError extends MovieRuntimeState {
  const MovieRuntimeError(DioException error) : super(error: error);
}

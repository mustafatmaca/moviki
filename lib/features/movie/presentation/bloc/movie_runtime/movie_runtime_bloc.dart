import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/domain/usecases/get_movie_runtime.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_runtime/movie_runtime_event.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_runtime/movie_runtime_state.dart';

class MovieRuntimeBloc extends Bloc<MovieRuntimeEvent, MovieRuntimeState> {
  final GetMovieRuntimeUseCase _getMovieRuntimeUseCase;
  MovieRuntimeBloc(this._getMovieRuntimeUseCase)
      : super(const MovieRuntimeInitial()) {
    on<GetRuntime>(onGetRuntime);
    on<ResetRuntime>(onResetRuntime);
  }

  Future<FutureOr<void>> onGetRuntime(
      GetRuntime event, Emitter<MovieRuntimeState> emit) async {
    emit(const MovieRuntimeLoading());

    final dataState = await _getMovieRuntimeUseCase(params: event.movieId);

    if (dataState is DataSuccess) {
      emit(MovieRuntimeLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(MovieRuntimeError(dataState.error!));
    }
  }

  FutureOr<void> onResetRuntime(
      ResetRuntime event, Emitter<MovieRuntimeState> emit) {
    emit(const MovieRuntimeInitial());
  }
}

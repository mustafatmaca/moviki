import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/domain/usecases/get_similar_movies.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_event.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_state.dart';

class SimilarMoviesBloc extends Bloc<SimilarMoviesEvent, SimilarMoviesState> {
  final GetSimilarMoviesUseCase _getSimilarMoviesUseCase;
  SimilarMoviesBloc(this._getSimilarMoviesUseCase)
      : super(SimilarMoviesInitial()) {
    on<GetSimilarMovies>(onGetSimilarMovies);
  }

  FutureOr<void> onGetSimilarMovies(
      GetSimilarMovies event, Emitter<SimilarMoviesState> emit) async {
    emit(const SimilarMoviesLoading());

    final dataState = await _getSimilarMoviesUseCase(params: event.id);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(SimilarMoviesLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(SimilarMoviesError(dataState.error!));
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/domain/usecases/get_toprated_movie.dart';
import 'package:moviki/features/movie/presentation/bloc/all_top/all_top_event.dart';
import 'package:moviki/features/movie/presentation/bloc/all_top/all_top_state.dart';

class AllTopBloc extends Bloc<AllTopEvent, AllTopState> {
  final GetTopRatedMovieUseCase _getTopRatedMovieUseCase;
  AllTopBloc(this._getTopRatedMovieUseCase) : super(AllTopInitial()) {
    on<AllTopEvent>(onGetAllTopRatedMovies);
  }

  Future<void> onGetAllTopRatedMovies(
      AllTopEvent event, Emitter<AllTopState> emit) async {
    emit(AllTopLoading());

    final dataState = await _getTopRatedMovieUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(AllTopLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(AllTopError(dataState.error!));
    }
  }
}

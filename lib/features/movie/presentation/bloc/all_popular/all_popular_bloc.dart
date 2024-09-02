import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/domain/usecases/get_popular_movie.dart';
import 'package:moviki/features/movie/presentation/bloc/all_popular/all_popular_event.dart';
import 'package:moviki/features/movie/presentation/bloc/all_popular/all_popular_state.dart';

class AllPopularBloc extends Bloc<AllPopularEvent, AllPopularState> {
  final GetPopularMovieUseCase _getPopularMovieUseCase;

  AllPopularBloc(this._getPopularMovieUseCase) : super(AllPopularInitial()) {
    on<GetAllPopularMovies>(onGetAllPopularMovies);
  }

  Future<void> onGetAllPopularMovies(
      GetAllPopularMovies event, Emitter<AllPopularState> emit) async {
    emit(const AllPopularLoading());

    final dataState = await _getPopularMovieUseCase(params: event.page);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(AllPopularLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(AllPopularError(dataState.error!));
    }
  }
}

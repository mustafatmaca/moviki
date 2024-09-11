import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/domain/usecases/get_movie_provider.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_event.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_state.dart';

class MovieProvidersBloc
    extends Bloc<MovieProvidersEvent, MovieProvidersState> {
  final GetMovieProviderUseCase _getMovieProviderUseCase;
  MovieProvidersBloc(this._getMovieProviderUseCase)
      : super(const MovieProvidersInitial()) {
    on<GetMovieProviders>(onGetMovieProviders);
  }

  Future<FutureOr<void>> onGetMovieProviders(
      GetMovieProviders event, Emitter<MovieProvidersState> emit) async {
    emit(const MovieProvidersLoading());

    final dataState = await _getMovieProviderUseCase(params: event.id);

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(MovieProvidersLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(MovieProvidersError(dataState.error!));
    }
  }
}

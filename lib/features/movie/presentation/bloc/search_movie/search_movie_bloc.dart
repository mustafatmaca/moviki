import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/domain/usecases/search_movie.dart';
import 'package:moviki/features/movie/presentation/bloc/search_movie/search_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/search_movie/search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovieUseCase _searchMovieUseCase;
  SearchMovieBloc(this._searchMovieUseCase)
      : super(const SearchMovieInitial()) {
    on<SearchMovies>(onSearchMovies);
  }

  Future<FutureOr<void>> onSearchMovies(
      SearchMovies event, Emitter<SearchMovieState> emit) async {
    if (event.query != null && event.query != "") {
      final dataState = await _searchMovieUseCase(params: event.query);

      if (dataState is DataSuccess) {
        emit(SearchMovieLoaded(dataState.data!));
      }

      if (dataState is DataFailed) {
        emit(SearchMovieError(dataState.error!));
      }
    }
  }
}

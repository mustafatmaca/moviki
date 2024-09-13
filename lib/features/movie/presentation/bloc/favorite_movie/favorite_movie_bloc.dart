import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moviki/features/movie/domain/usecases/get_favorite_movie.dart';
import 'package:moviki/features/movie/domain/usecases/remove_movie.dart';
import 'package:moviki/features/movie/domain/usecases/save_movie.dart';
import 'package:moviki/features/movie/presentation/bloc/favorite_movie/favorite_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/favorite_movie/favorite_movie_state.dart';

class FavoriteMovieBloc extends Bloc<FavoriteMovieEvent, FavoriteMovieState> {
  final GetFavoriteMovieUseCase _getFavoriteMovieUseCase;
  final SaveMovieUseCase _saveMovieUseCase;
  final RemoveMovieUseCase _removeMovieUseCase;
  FavoriteMovieBloc(this._getFavoriteMovieUseCase, this._saveMovieUseCase,
      this._removeMovieUseCase)
      : super(const FavoriteMovieInitial()) {
    on<GetFavoriteMovies>(onGetFavoriteMovies);
    on<SaveMovie>(onSaveMovie);
    on<RemoveMovie>(onRemoveMovie);
  }

  Future<FutureOr<void>> onGetFavoriteMovies(
      GetFavoriteMovies event, Emitter<FavoriteMovieState> emit) async {
    final movies = await _getFavoriteMovieUseCase();
    emit(FavoriteMovieLoaded(movies));
  }

  Future<FutureOr<void>> onSaveMovie(
      SaveMovie event, Emitter<FavoriteMovieState> emit) async {
    await _saveMovieUseCase(params: event.movie);
    final movies = await _getFavoriteMovieUseCase();
    emit(FavoriteMovieLoaded(movies));
  }

  Future<FutureOr<void>> onRemoveMovie(
      RemoveMovie event, Emitter<FavoriteMovieState> emit) async {
    await _removeMovieUseCase(params: event.movie);
    final movies = await _getFavoriteMovieUseCase();
    emit(FavoriteMovieLoaded(movies));
  }
}

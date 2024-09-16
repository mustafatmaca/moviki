import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moviki/features/movie/domain/usecases/get_fav_movie_by_id.dart';
import 'package:moviki/features/movie/presentation/bloc/is_favorite/is_favorite_event.dart';
import 'package:moviki/features/movie/presentation/bloc/is_favorite/is_favorite_state.dart';

class IsFavoriteBloc extends Bloc<IsFavoriteEvent, IsFavoriteState> {
  final GetFavMovieByIdUseCase _getFavMovieByIdUseCase;
  IsFavoriteBloc(this._getFavMovieByIdUseCase)
      : super(const IsFavoriteInitial()) {
    on<GetFavoriteMovieById>(onGetFavoriteMovieById);
  }

  Future<FutureOr<void>> onGetFavoriteMovieById(
      IsFavoriteEvent event, Emitter<IsFavoriteState> emit) async {
    final movie = await _getFavMovieByIdUseCase(params: event.id);
    if (movie != null) {
      emit(IsFavoriteLoaded(movie));
    } else {
      emit(const IsFavoriteError());
    }
  }
}

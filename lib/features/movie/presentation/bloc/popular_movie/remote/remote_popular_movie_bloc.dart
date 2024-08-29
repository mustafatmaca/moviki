import 'package:bloc/bloc.dart';
import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/domain/usecases/get_popular_movie.dart';
import 'package:moviki/features/movie/presentation/bloc/popular_movie/remote/remote_popular_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/popular_movie/remote/remote_popular_movie_state.dart';

class RemotePopularMovieBloc
    extends Bloc<RemotePopularMovieEvent, RemotePopularMovieState> {
  final GetPopularMovieUseCase _getPopularMovieUseCase;

  RemotePopularMovieBloc(this._getPopularMovieUseCase)
      : super(RemotePopularMovieInitial()) {
    on<GetPopularMovies>(onGetPopularMovies);
  }

  Future<void> onGetPopularMovies(
      GetPopularMovies event, Emitter<RemotePopularMovieState> emit) async {
    emit(const RemotePopularMovieLoading());

    final dataState = await _getPopularMovieUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemotePopularMovieLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemotePopularMovieError(dataState.error!));
    }
  }
}

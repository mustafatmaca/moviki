import 'package:bloc/bloc.dart';
import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/domain/usecases/get_popular_movie.dart';
import 'package:moviki/features/movie/presentation/bloc/movie/remote/remote_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/movie/remote/remote_movie_state.dart';

class RemoteMovieBloc extends Bloc<RemoteMovieEvent, RemoteMovieState> {
  final GetPopularMovieUseCase _getPopularMovieUseCase;

  RemoteMovieBloc(this._getPopularMovieUseCase) : super(RemoteMovieInitial()) {
    on<GetPopularMovies>(onGetPopularMovies);
  }

  Future<void> onGetPopularMovies(
      GetPopularMovies event, Emitter<RemoteMovieState> emit) async {
    emit(const RemoteMovieLoading());

    final dataState = await _getPopularMovieUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteMovieLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteMovieError(dataState.error!));
    }
  }
}

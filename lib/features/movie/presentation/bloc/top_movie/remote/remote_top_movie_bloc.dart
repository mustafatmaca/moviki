import 'package:bloc/bloc.dart';
import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/domain/usecases/get_toprated_movie.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_state.dart';

class RemoteTopMovieBloc
    extends Bloc<RemoteTopMovieEvent, RemoteTopMovieState> {
  final GetTopRatedMovieUseCase _getTopRatedMovieUseCase;
  RemoteTopMovieBloc(this._getTopRatedMovieUseCase)
      : super(RemoteTopMovieInitial()) {
    on<GetTopRatedMovies>(onGetTopRatedMovies);
  }

  Future<void> onGetTopRatedMovies(
      GetTopRatedMovies event, Emitter<RemoteTopMovieState> emit) async {
    emit(RemoteTopMovieLoading());

    final dataState = await _getTopRatedMovieUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteTopMovieLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteTopMovieError(dataState.error!));
    }
  }
}

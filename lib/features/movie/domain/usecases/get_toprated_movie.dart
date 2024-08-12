import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
import 'package:moviki/features/movie/domain/repository/movie_repository.dart';

class GetTopRatedMovieUseCase
    implements UseCase<DataState<List<MovieEntity>>, void> {
  final MovieRepository _movieRepository;

  GetTopRatedMovieUseCase(this._movieRepository);

  @override
  Future<DataState<List<MovieEntity>>> call({void params}) {
    return _movieRepository.getTopRatedMovies();
  }
}

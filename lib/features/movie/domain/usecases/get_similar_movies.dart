import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
import 'package:moviki/features/movie/domain/repository/movie_repository.dart';

class GetSimilarMoviesUseCase
    implements UseCase<DataState<List<MovieEntity>>, int> {
  final MovieRepository _movieRepository;

  GetSimilarMoviesUseCase(this._movieRepository);

  @override
  Future<DataState<List<MovieEntity>>> call({int? params}) {
    return _movieRepository.getSimilarMovies(params);
  }
}

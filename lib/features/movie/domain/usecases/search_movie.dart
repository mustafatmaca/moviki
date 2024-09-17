import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
import 'package:moviki/features/movie/domain/repository/movie_repository.dart';

class SearchMovieUseCase
    implements UseCase<DataState<List<MovieEntity>>, String> {
  final MovieRepository _movieRepository;

  SearchMovieUseCase(this._movieRepository);

  @override
  Future<DataState<List<MovieEntity>>> call({String? params}) {
    return _movieRepository.searchMovies(params);
  }
}

import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
import 'package:moviki/features/movie/domain/repository/movie_repository.dart';

class GetFavoriteMovieUseCase implements UseCase<List<MovieEntity>, void> {
  final MovieRepository _movieRepository;

  GetFavoriteMovieUseCase(this._movieRepository);

  @override
  Future<List<MovieEntity>> call({void params}) {
    return _movieRepository.getFavoriteMovies();
  }
}

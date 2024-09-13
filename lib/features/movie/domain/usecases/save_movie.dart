import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
import 'package:moviki/features/movie/domain/repository/movie_repository.dart';

class SaveMovieUseCase implements UseCase<void, MovieEntity> {
  final MovieRepository _movieRepository;

  SaveMovieUseCase(this._movieRepository);

  @override
  Future<void> call({MovieEntity? params}) {
    return _movieRepository.saveMovie(params!);
  }
}

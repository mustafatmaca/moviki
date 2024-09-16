import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
import 'package:moviki/features/movie/domain/repository/movie_repository.dart';

class GetFavMovieByIdUseCase implements UseCase<MovieEntity?, int> {
  final MovieRepository _movieRepository;

  GetFavMovieByIdUseCase(this._movieRepository);

  @override
  Future<MovieEntity?> call({int? params}) {
    return _movieRepository.getFavoriteMovieById(params!);
  }
}

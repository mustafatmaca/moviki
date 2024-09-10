import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<DataState<List<MovieEntity>>> getPopularMovies(int? page);
  Future<DataState<List<MovieEntity>>> getTopRatedMovies();
  Future<DataState<List<MovieEntity>>> getSimilarMovies(int? movieId);
  Future<DataState<int>> getMovieRuntime(int? movieId);
}

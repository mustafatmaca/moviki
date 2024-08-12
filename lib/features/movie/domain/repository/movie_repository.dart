import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<DataState<List<MovieEntity>>> getPopularMovies();
  Future<DataState<List<MovieEntity>>> getTopRatedMovies();
}

import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/domain/entities/movie_provider.dart';

abstract class MovieProviderRepository {
  Future<DataState<List<MovieProviderEntity>>> getMovieProviders(int? movieId);
}

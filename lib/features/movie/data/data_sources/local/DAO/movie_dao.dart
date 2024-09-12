import 'package:floor/floor.dart';
import 'package:moviki/features/movie/data/models/movie_model.dart';

@dao
abstract class MovieDao {
  @Insert()
  Future<void> insertMovie(MovieModel movie);

  @delete
  Future<void> deleteMovie(MovieModel movie);

  @Query('SELECT * FROM movie')
  Future<List<MovieModel>> getMovies();
}

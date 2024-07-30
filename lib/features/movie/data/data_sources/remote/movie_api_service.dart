import 'package:dio/dio.dart';
import 'package:moviki/core/constants/constants.dart';
import 'package:moviki/features/movie/data/models/movie_model.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_api_service.g.dart';

@RestApi(baseUrl: movieAPIBaseURL)
abstract class MovieApiService {
  factory MovieApiService(Dio dio) = _MovieApiService;

  @GET('/movie/popular')
  Future<HttpResponse<List<MovieModel>>> getPopularMovies({
    @Query("api_key") String? apiKey,
    @Query("page") String? page,
    @Query("language") String? language,
    @Query("region") String? region,
  });
}

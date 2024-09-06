import 'package:dio/dio.dart';
import 'package:moviki/core/constants/constants.dart';
import 'package:moviki/features/movie/data/models/movie_model.dart';
import 'package:moviki/features/movie/data/models/movie_provider_model.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_api_service.g.dart';

@RestApi(baseUrl: movieAPIBaseURL)
abstract class MovieApiService {
  factory MovieApiService(Dio dio) = _MovieApiService;

  @GET('/movie/popular')
  Future<HttpResponse<List<MovieModel>>> getPopularMovies({
    @Query("api_key") String? apiKey,
    @Query("page") int? page,
    @Query("language") String? language,
    @Query("region") String? region,
  });

  @GET('/movie/top_rated')
  Future<HttpResponse<List<MovieModel>>> getTopRatedMovies({
    @Query("api_key") String? apiKey,
    @Query("page") int? page,
    @Query("language") String? language,
    @Query("region") String? region,
  });

  @GET('/movie/{movie_id}/watch/providers')
  Future<HttpResponse<List<MovieProviderModel>>> getMovieProviders({
    @Path("movie_id") int? movieId,
    @Query("api_key") String? apiKey,
  });
}

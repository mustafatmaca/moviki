import 'package:dio/dio.dart';
import 'package:moviki/core/constants/constants.dart';
import 'package:moviki/features/country/data/models/country_model.dart';
import 'package:retrofit/retrofit.dart';

part 'country_api_service.g.dart';

@RestApi(baseUrl: movieAPIBaseURL)
abstract class CountryApiService {
  factory CountryApiService(Dio dio) = _CountryApiService;

  @GET('/configuration/countries')
  Future<HttpResponse<List<CountryModel>>> getCountries({
    @Query("api_key") String? apiKey,
  });
}

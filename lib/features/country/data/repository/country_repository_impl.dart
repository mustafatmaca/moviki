import 'dart:io';

import 'package:dio/dio.dart';
import 'package:moviki/core/constants/constants.dart';
import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/country/data/data_sources/remote/country_api_service.dart';
import 'package:moviki/features/country/data/models/country_model.dart';
import 'package:moviki/features/country/domain/repository/country_repository.dart';

class CountryRepositoryImpl implements CountryRepository {
  final CountryApiService _countryApiService;

  CountryRepositoryImpl(this._countryApiService);

  @override
  Future<DataState<List<CountryModel>>> getCountries() async {
    try {
      final httpResponse = await _countryApiService.getCountries(
        apiKey: apiKey,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}

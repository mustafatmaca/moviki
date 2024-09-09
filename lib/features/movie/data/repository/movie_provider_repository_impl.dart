import 'dart:io';

import 'package:dio/dio.dart';
import 'package:moviki/core/constants/constants.dart';
import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/data/data_sources/remote/movie_api_service.dart';
import 'package:moviki/features/movie/domain/entities/movie_provider.dart';
import 'package:moviki/features/movie/domain/repository/movie_provider_repository.dart';

class MovieProviderRepositoryImpl implements MovieProviderRepository {
  final MovieApiService _movieApiService;

  MovieProviderRepositoryImpl(this._movieApiService);

  @override
  Future<DataState<List<MovieProviderEntity>?>> getMovieProviders(
      int? movieId) async {
    try {
      final httpResponse = await _movieApiService.getMovieProviders(
        apiKey: apiKey,
        movieId: movieId,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        if (httpResponse.data!.isEmpty) {
          return DataFailed(
            DioException(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioExceptionType.badResponse,
                requestOptions: httpResponse.response.requestOptions,
                message: "There are no providers!"),
          );
        } else {
          return DataSuccess(httpResponse.data);
        }
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions,
              message: "There is a unexcepted result!"),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}

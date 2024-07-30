import 'dart:io';

import 'package:dio/dio.dart';
import 'package:moviki/core/constants/constants.dart';
import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/movie/data/data_sources/remote/movie_api_service.dart';
import 'package:moviki/features/movie/data/models/movie_model.dart';
import 'package:moviki/features/movie/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService _movieApiService;

  MovieRepositoryImpl(this._movieApiService);

  @override
  Future<DataState<List<MovieModel>>> getPopularMovies() async {
    try {
      final httpResponse = await _movieApiService.getPopularMovies(
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

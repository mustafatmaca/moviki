import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moviki/features/movie/data/data_sources/remote/movie_api_service.dart';
import 'package:moviki/features/movie/data/repository/movie_repository_impl.dart';
import 'package:moviki/features/movie/domain/repository/movie_repository.dart';
import 'package:moviki/features/movie/domain/usecases/get_popular_movie.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie/remote/remote_movie_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerSingleton<MovieApiService>(MovieApiService(getIt()));

  getIt.registerSingleton<MovieRepository>(MovieRepositoryImpl(getIt()));

  getIt.registerSingleton<GetPopularMovieUseCase>(
      GetPopularMovieUseCase(getIt()));

  getIt.registerFactory<RemoteMovieBloc>(() => RemoteMovieBloc(getIt()));

  getIt.registerFactory<BottomNavigationBloc>(() => BottomNavigationBloc());
}

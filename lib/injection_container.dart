import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moviki/features/movie/data/data_sources/local/app_database.dart';
import 'package:moviki/features/movie/data/data_sources/remote/movie_api_service.dart';
import 'package:moviki/features/movie/data/repository/movie_provider_repository_impl.dart';
import 'package:moviki/features/movie/data/repository/movie_repository_impl.dart';
import 'package:moviki/features/movie/domain/repository/movie_provider_repository.dart';
import 'package:moviki/features/movie/domain/repository/movie_repository.dart';
import 'package:moviki/features/movie/domain/usecases/get_fav_movie_by_id.dart';
import 'package:moviki/features/movie/domain/usecases/get_favorite_movie.dart';
import 'package:moviki/features/movie/domain/usecases/get_movie_provider.dart';
import 'package:moviki/features/movie/domain/usecases/get_movie_runtime.dart';
import 'package:moviki/features/movie/domain/usecases/get_popular_movie.dart';
import 'package:moviki/features/movie/domain/usecases/get_similar_movies.dart';
import 'package:moviki/features/movie/domain/usecases/get_toprated_movie.dart';
import 'package:moviki/features/movie/domain/usecases/remove_movie.dart';
import 'package:moviki/features/movie/domain/usecases/save_movie.dart';
import 'package:moviki/features/movie/domain/usecases/search_movie.dart';
import 'package:moviki/features/movie/presentation/bloc/all_popular/all_popular_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/all_top/all_top_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/favorite_movie/favorite_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/is_favorite/is_favorite_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_runtime/movie_runtime_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/popular_movie/remote/remote_popular_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_bloc.dart';
import 'package:moviki/features/splash/data/data_sources/remote/country_api_service.dart';
import 'package:moviki/features/splash/data/repository/country_repository_impl.dart';
import 'package:moviki/features/splash/domain/repository/country_repository.dart';
import 'package:moviki/features/splash/domain/usecases/get_countries.dart';
import 'package:moviki/features/splash/presentation/bloc/country/country_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  getIt.registerSingleton<AppDatabase>(database);

  getIt.registerSingleton<Dio>(Dio());

  getIt.registerSingleton<MovieApiService>(MovieApiService(getIt()));

  getIt.registerSingleton<CountryApiService>(CountryApiService(getIt()));

  getIt.registerSingleton<MovieRepository>(
      MovieRepositoryImpl(getIt(), getIt()));

  getIt.registerSingleton<MovieProviderRepository>(
      MovieProviderRepositoryImpl(getIt()));

  getIt.registerSingleton<CountryRepository>(CountryRepositoryImpl(getIt()));

  getIt.registerSingleton<GetPopularMovieUseCase>(
      GetPopularMovieUseCase(getIt()));

  getIt.registerSingleton(GetTopRatedMovieUseCase(getIt()));

  getIt.registerSingleton(GetMovieProviderUseCase(getIt()));

  getIt.registerSingleton(GetSimilarMoviesUseCase(getIt()));

  getIt.registerSingleton(GetMovieRuntimeUseCase(getIt()));

  getIt.registerSingleton(SearchMovieUseCase(getIt()));

  getIt.registerSingleton(GetFavoriteMovieUseCase(getIt()));

  getIt.registerSingleton(GetFavMovieByIdUseCase(getIt()));

  getIt.registerSingleton(SaveMovieUseCase(getIt()));

  getIt.registerSingleton(RemoveMovieUseCase(getIt()));

  getIt.registerSingleton(GetCountriesUseCase(getIt()));

  getIt.registerFactory<RemotePopularMovieBloc>(
      () => RemotePopularMovieBloc(getIt()));

  getIt.registerFactory<AllPopularBloc>(() => AllPopularBloc(getIt()));

  getIt.registerFactory<RemoteTopMovieBloc>(() => RemoteTopMovieBloc(getIt()));

  getIt.registerFactory<AllTopBloc>(() => AllTopBloc(getIt()));

  getIt.registerFactory<MovieProvidersBloc>(() => MovieProvidersBloc(getIt()));

  getIt.registerFactory<SimilarMoviesBloc>(() => SimilarMoviesBloc(getIt()));

  getIt.registerFactory<MovieRuntimeBloc>(() => MovieRuntimeBloc(getIt()));

  getIt.registerFactory<SearchMovieBloc>(() => SearchMovieBloc(getIt()));

  getIt.registerFactory<BottomNavigationBloc>(() => BottomNavigationBloc());

  getIt.registerFactory<FavoriteMovieBloc>(
    () => FavoriteMovieBloc(getIt(), getIt(), getIt()),
  );

  getIt.registerFactory<IsFavoriteBloc>(
    () => IsFavoriteBloc(getIt()),
  );

  getIt.registerFactory<CountryBloc>(
    () => CountryBloc(getIt()),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/config/theme/app_theme.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:moviki/features/movie/presentation/bloc/favorite_movie/favorite_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/favorite_movie/favorite_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/popular_movie/remote/remote_popular_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/popular_movie/remote/remote_popular_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/search_movie/search_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_event.dart';
import 'package:moviki/features/movie/presentation/pages/home_screen.dart';
import 'package:moviki/features/splash/domain/usecases/get_is_open.dart';
import 'package:moviki/features/country/presentation/bloc/country/country_bloc.dart';
import 'package:moviki/features/country/presentation/bloc/country/country_event.dart';
import 'package:moviki/features/country/presentation/bloc/select_country/select_country_bloc.dart';
import 'package:moviki/features/splash/presentation/pages/splash_screen.dart';
import 'package:moviki/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<RemotePopularMovieBloc>(
        create: (context) => getIt()..add(const GetPopularMovies()),
      ),
      BlocProvider<RemoteTopMovieBloc>(
        create: (context) => getIt()..add(const GetTopRatedMovies()),
      ),
      BlocProvider<FavoriteMovieBloc>(
        create: (context) => getIt()..add(const GetFavoriteMovies()),
      ),
      BlocProvider<SearchMovieBloc>(
        create: (context) => getIt()..add(const SearchMovies()),
      ),
      BlocProvider<BottomNavigationBloc>(
        create: (context) => getIt()..add(const ChangePage(0)),
      ),
      BlocProvider<CountryBloc>(
        create: (context) => getIt()..add(const GetCountries()),
      ),
      BlocProvider<SelectCountryBloc>(
        create: (context) => getIt(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moviki',
      theme: AppTheme.theme,
      home: await getIt<GetIsOpenUseCase>().call() == null ||
              await getIt<GetIsOpenUseCase>().call() == false
          ? const SplashScreen()
          : const HomeScreen(),
    ),
  ));
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moviki',
      home: SplashScreen(),
    ),
  ));
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/all_popular/all_popular_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/all_popular/all_popular_event.dart';
import 'package:moviki/features/movie/presentation/bloc/all_top/all_top_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/all_top/all_top_event.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_event.dart';
import 'package:moviki/features/movie/presentation/bloc/popular_movie/remote/remote_popular_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/popular_movie/remote/remote_popular_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_event.dart';
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
      BlocProvider<AllPopularBloc>(
        create: (context) => getIt()..add(const GetAllPopularMovies()),
      ),
      BlocProvider<AllTopBloc>(
        create: (context) => getIt()..add(const GetAllTopRatedMovies()),
      ),
      BlocProvider<MovieProvidersBloc>(
        create: (context) => getIt()..add(const GetMovieProviders()),
      ),
      BlocProvider<SimilarMoviesBloc>(
        create: (context) => getIt()..add(const GetSimilarMovies()),
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

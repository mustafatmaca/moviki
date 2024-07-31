import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie/remote/remote_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie/remote/remote_movie_event.dart';
import 'package:moviki/features/splash/presentation/pages/splash_screen.dart';
import 'package:moviki/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<RemoteMovieBloc>(
        create: (context) => getIt()..add(const GetPopularMovies()),
      ),
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moviki',
      home: SplashScreen(),
    ),
  ));
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
import 'package:moviki/features/movie/presentation/bloc/is_favorite/is_favorite_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_runtime/movie_runtime_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_bloc.dart';
import 'package:moviki/features/movie/presentation/pages/movie_detail_screen.dart';
import 'package:moviki/injection_container.dart';

class CustomTopSlider extends StatelessWidget {
  final List<MovieEntity> movieList;
  final PageController _pageController = PageController();

  CustomTopSlider({super.key, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, pageIndex) {
        return buildFilmCard(movieList[pageIndex], context);
      },
      itemCount: 3, // Adjust this to the total number of pages
    );
  }
}

buildFilmCard(MovieEntity movie, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MultiBlocProvider(
                    providers: [
                      BlocProvider<MovieProvidersBloc>.value(value: getIt()),
                      BlocProvider<MovieRuntimeBloc>.value(value: getIt()),
                      BlocProvider<SimilarMoviesBloc>.value(value: getIt()),
                      BlocProvider<IsFavoriteBloc>.value(value: getIt()),
                    ],
                    child: MovieDetailScreen(movie: movie),
                  )));
    },
    child: movie.posterPath != null
        ? Container(
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: CachedNetworkImageProvider(
                        "https://image.tmdb.org/t/p/w500/${movie.posterPath}"))),
          )
        : Container(
            width: MediaQuery.of(context).size.width * 0.26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black,
            ),
            child: const Center(
              child: Text(
                "NO IMAGE",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
  );
}

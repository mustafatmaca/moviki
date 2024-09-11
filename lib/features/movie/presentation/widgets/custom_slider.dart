import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_runtime/movie_runtime_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_bloc.dart';
import 'package:moviki/features/movie/presentation/pages/movie_detail_screen.dart';
import 'package:moviki/injection_container.dart';

class CustomSlider extends StatelessWidget {
  final List<MovieEntity> movieList;
  final PageController _pageController = PageController(viewportFraction: 0.9);

  CustomSlider({super.key, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, pageIndex) {
        return Row(children: [
          buildFilmCard(movieList[pageIndex * 3], context),
          buildFilmCard(movieList[pageIndex * 3 + 1], context),
          buildFilmCard(movieList[pageIndex * 3 + 2], context),
        ]);
      },
      itemCount:
          movieList.length ~/ 3, // Adjust this to the total number of pages
    );
  }
}

buildFilmCard(MovieEntity movie, BuildContext context) {
  return Expanded(
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider<MovieProvidersBloc>.value(value: getIt()),
                        BlocProvider<MovieRuntimeBloc>.value(value: getIt()),
                        BlocProvider<SimilarMoviesBloc>.value(value: getIt()),
                      ],
                      child: MovieDetailScreen(movie: movie),
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                    "https://image.tmdb.org/t/p/w200/${movie.posterPath}"))),
      ),
    ),
  );
}

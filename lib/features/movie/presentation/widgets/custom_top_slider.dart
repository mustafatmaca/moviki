import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_event.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_event.dart';
import 'package:moviki/features/movie/presentation/pages/movie_detail_screen.dart';

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
      context.read<MovieProvidersBloc>().add(const ResetState());
      context.read<SimilarMoviesBloc>().add(const ResetSimilarMovies());
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ));
    },
    child: Container(
      decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              fit: BoxFit.contain,
              image: CachedNetworkImageProvider(
                  "https://image.tmdb.org/t/p/w500/${movie.posterPath}"))),
    ),
  );
}

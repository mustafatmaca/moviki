import 'package:flutter/material.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

class CustomTopSlider extends StatelessWidget {
  final List<MovieEntity> movieList;
  final PageController _pageController = PageController();

  CustomTopSlider({super.key, required this.movieList});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, pageIndex) {
        return buildFilmCard(movieList[pageIndex]);
      },
      itemCount: 3, // Adjust this to the total number of pages
    );
  }
}

buildFilmCard(MovieEntity movie) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
            fit: BoxFit.contain,
            image: NetworkImage(
                "https://image.tmdb.org/t/p/w500/${movie.posterPath}"))),
  );
}

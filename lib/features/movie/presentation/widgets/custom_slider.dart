import 'package:flutter/material.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';

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
          buildFilmCard(movieList[pageIndex * 3]),
          buildFilmCard(movieList[pageIndex * 3 + 1]),
          buildFilmCard(movieList[pageIndex * 3 + 2]),
        ]);
      },
      itemCount:
          movieList.length ~/ 3, // Adjust this to the total number of pages
    );
  }
}

buildFilmCard(MovieEntity movie) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
              image: NetworkImage(
                  "https://image.tmdb.org/t/p/w200/${movie.posterPath}"))),
    ),
  );
}

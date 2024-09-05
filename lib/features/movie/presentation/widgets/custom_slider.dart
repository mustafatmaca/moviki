import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
import 'package:moviki/features/movie/presentation/pages/movie_detail_screen.dart';

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
              builder: (context) => MovieDetailScreen(movie: movie),
            ));
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

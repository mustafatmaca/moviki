import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_event.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_event.dart';
import 'package:moviki/features/movie/presentation/pages/movie_detail_screen.dart';

class CustomListCard extends StatelessWidget {
  final MovieEntity movie;
  const CustomListCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.26,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "https://image.tmdb.org/t/p/w200/${movie.posterPath}"))),
            ),
            Container(
              padding: EdgeInsets.only(left: 4.0, top: 2, bottom: 2),
              width: MediaQuery.of(context).size.width * 0.68,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          movie.title!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      Text(
                        movie.releaseDate!.substring(0, 4),
                        style: TextStyle(color: Colors.white54, fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    "${movie.overview}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: TextStyle(color: Colors.white38, fontSize: 12),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

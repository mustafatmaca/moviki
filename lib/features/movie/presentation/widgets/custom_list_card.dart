import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/config/theme/app_color.dart';
import 'package:moviki/config/theme/app_theme.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
import 'package:moviki/features/movie/presentation/bloc/is_favorite/is_favorite_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_runtime/movie_runtime_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_bloc.dart';
import 'package:moviki/features/movie/presentation/pages/movie_detail_screen.dart';
import 'package:moviki/injection_container.dart';

class CustomListCard extends StatelessWidget {
  final MovieEntity movie;
  const CustomListCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        padding: EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            movie.posterPath != null
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.26,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.background,
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                "https://image.tmdb.org/t/p/w200/${movie.posterPath}"))),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width * 0.26,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.background,
                    ),
                    child: const Center(
                      child: Text(
                        "NO IMAGE",
                        style: TextStyle(color: AppColor.labelOne),
                      ),
                    ),
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
                        child: Text(movie.title!,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.theme.textTheme.titleMedium!
                                .copyWith(color: AppColor.labelOne)),
                      ),
                      movie.releaseDate != null &&
                              movie.releaseDate!.length >= 5
                          ? Text(movie.releaseDate!.substring(0, 4),
                              style: AppTheme.theme.textTheme.titleSmall!
                                  .copyWith(color: AppColor.labelThree))
                          : Container(),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text("${movie.overview}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: AppTheme.theme.textTheme.bodyLarge!
                          .copyWith(color: AppColor.labelFour))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

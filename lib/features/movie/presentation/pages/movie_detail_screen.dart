import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/config/theme/app_color.dart';
import 'package:moviki/config/theme/app_theme.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
import 'package:moviki/features/movie/presentation/bloc/favorite_movie/favorite_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/favorite_movie/favorite_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/is_favorite/is_favorite_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/is_favorite/is_favorite_event.dart';
import 'package:moviki/features/movie/presentation/bloc/is_favorite/is_favorite_state.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_event.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_providers/movie_providers_state.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_runtime/movie_runtime_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_runtime/movie_runtime_event.dart';
import 'package:moviki/features/movie/presentation/bloc/movie_runtime/movie_runtime_state.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_event.dart';
import 'package:moviki/features/movie/presentation/bloc/similar_movies/similar_movies_state.dart';
import 'package:moviki/injection_container.dart';

class MovieDetailScreen extends StatelessWidget {
  final MovieEntity movie;
  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                movie.posterPath != null
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColor.background,
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    "https://image.tmdb.org/t/p/w500/${movie.posterPath}"))),
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
                            style: TextStyle(
                              color: AppColor.labelOne,
                            ),
                          ),
                        ),
                      ),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.015,
                    right: MediaQuery.of(context).size.width * 0.02,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: AppColor.background,
                        child: BlocBuilder<IsFavoriteBloc, IsFavoriteState>(
                          builder: (context, state) {
                            if (state is IsFavoriteInitial) {
                              context
                                  .read<IsFavoriteBloc>()
                                  .add(GetFavoriteMovieById(movie.id!));
                              return Container();
                            } else if (state is IsFavoriteLoaded) {
                              return IconButton(
                                  onPressed: () {
                                    context
                                        .read<FavoriteMovieBloc>()
                                        .add(RemoveMovie(movie));
                                    context
                                        .read<IsFavoriteBloc>()
                                        .add(GetFavoriteMovieById(movie.id!));
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                  ));
                            } else if (state is IsFavoriteError) {
                              return IconButton(
                                  onPressed: () {
                                    context
                                        .read<FavoriteMovieBloc>()
                                        .add(SaveMovie(movie));
                                    context
                                        .read<IsFavoriteBloc>()
                                        .add(GetFavoriteMovieById(movie.id!));
                                  },
                                  icon: const Icon(
                                    Icons.favorite_border,
                                  ));
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ),
                    )),
              ],
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          movie.title!,
                          style:
                              AppTheme.theme.textTheme.headlineMedium!.copyWith(
                            color: AppColor.labelOne,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(movie.releaseDate!.substring(0, 4),
                          style: AppTheme.theme.textTheme.titleMedium!.copyWith(
                            color: AppColor.labelFour,
                            fontWeight: FontWeight.bold,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Text(movie.voteAverage.toString().substring(0, 3),
                          style: AppTheme.theme.textTheme.titleMedium!.copyWith(
                            color: AppColor.labelOne,
                            fontWeight: FontWeight.bold,
                          )),
                      Text("/10",
                          style: AppTheme.theme.textTheme.titleMedium!.copyWith(
                            color: AppColor.labelFour,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.star,
                        size: 18,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text("|",
                          style: AppTheme.theme.textTheme.titleMedium!.copyWith(
                            color: AppColor.labelOne,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        width: 6,
                      ),
                      BlocBuilder<MovieRuntimeBloc, MovieRuntimeState>(
                        builder: (context, state) {
                          if (state is MovieRuntimeInitial) {
                            context
                                .read<MovieRuntimeBloc>()
                                .add(GetRuntime(movieId: movie.id));
                            return Container();
                          } else if (state is MovieRuntimeLoaded) {
                            return Text(
                                "${(state.runtime! / 60).floor()} h ${(state.runtime! % 60)} min",
                                style: AppTheme.theme.textTheme.titleMedium!
                                    .copyWith(
                                  color: AppColor.labelFour,
                                  fontWeight: FontWeight.bold,
                                ));
                          } else {
                            return Text("* h * min",
                                style: AppTheme.theme.textTheme.titleMedium!
                                    .copyWith(
                                  color: AppColor.labelFour,
                                  fontWeight: FontWeight.bold,
                                ));
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("${movie.overview}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 8,
                      style: AppTheme.theme.textTheme.titleMedium!.copyWith(
                        color: AppColor.labelFour,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Platform",
                          style: AppTheme.theme.textTheme.titleMedium!.copyWith(
                            color: AppColor.labelOne,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        BlocBuilder<MovieProvidersBloc, MovieProvidersState>(
                          builder: (context, state) {
                            if (state is MovieProvidersInitial) {
                              context
                                  .read<MovieProvidersBloc>()
                                  .add(GetMovieProviders(id: movie.id!));
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width,
                                color: AppColor.transparent,
                              );
                            } else if (state is MovieProvidersLoading) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width,
                                color: AppColor.transparent,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (state is MovieProvidersLoaded) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: state.movieProviders!
                                      .map(
                                        (e) => Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.07,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.14,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: AppColor.transparent,
                                                image: DecorationImage(
                                                    image: CachedNetworkImageProvider(
                                                        "https://image.tmdb.org/t/p/original/${e.logoPath}"))),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              );
                            } else if (state is MovieProvidersError) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                color: AppColor.transparent,
                                child: Center(
                                    child: Text(
                                  state.error!.message!,
                                  style: AppTheme.theme.textTheme.titleLarge,
                                )),
                              );
                            } else {
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: AppColor.transparent,
                                child: Center(
                                    child: Text(
                                  "Something went wrong!",
                                  style: AppTheme.theme.textTheme.titleLarge,
                                )),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "More Like This",
                          style: AppTheme.theme.textTheme.titleMedium!.copyWith(
                            color: AppColor.labelOne,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        BlocBuilder<SimilarMoviesBloc, SimilarMoviesState>(
                          builder: (context, state) {
                            if (state is SimilarMoviesInitial) {
                              context
                                  .read<SimilarMoviesBloc>()
                                  .add(GetSimilarMovies(id: movie.id!));
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width,
                                color: AppColor.transparent,
                              );
                            } else if (state is SimilarMoviesLoading) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width,
                                color: AppColor.transparent,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (state is SimilarMoviesLoaded) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: state.movies!
                                      .map(
                                        (e) => InkWell(
                                          onTap: () async {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MultiBlocProvider(
                                                          providers: [
                                                            BlocProvider<
                                                                    MovieProvidersBloc>.value(
                                                                value: getIt()),
                                                            BlocProvider<
                                                                    MovieRuntimeBloc>.value(
                                                                value: getIt()),
                                                            BlocProvider<
                                                                    SimilarMoviesBloc>.value(
                                                                value: getIt()),
                                                            BlocProvider<
                                                                    IsFavoriteBloc>.value(
                                                                value: getIt()),
                                                          ],
                                                          child:
                                                              MovieDetailScreen(
                                                                  movie: e),
                                                        )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: e.posterPath != null
                                                ? Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.23,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: AppColor
                                                            .transparent,
                                                        image: DecorationImage(
                                                            image: CachedNetworkImageProvider(
                                                                "https://image.tmdb.org/t/p/w200/${e.posterPath}"))),
                                                  )
                                                : Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.26,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color:
                                                          AppColor.transparent,
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "NO IMAGE",
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .labelOne),
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              );
                            } else if (state is MovieProvidersError) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                color: AppColor.transparent,
                                child: Center(
                                    child: Text(
                                  state.error!.message!,
                                  style: AppTheme.theme.textTheme.titleLarge,
                                )),
                              );
                            } else {
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: AppColor.transparent,
                                child: Center(
                                    child: Text(
                                  "Something went wrong!",
                                  style: AppTheme.theme.textTheme.titleLarge,
                                )),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

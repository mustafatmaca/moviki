import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/movie/domain/entities/movie.dart';
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
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "https://image.tmdb.org/t/p/w500/${movie.posterPath}"))),
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
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        movie.releaseDate!.substring(0, 4),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white38),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        movie.voteAverage.toString().substring(0, 3),
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const Text(
                        "/10",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white38),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFF5046),
                        size: 18,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const Text(
                        "|",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
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
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white38),
                            );
                          } else {
                            return const Text(
                              "* h * min",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white38),
                            );
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "${movie.overview}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 8,
                    style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Platform",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
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
                                color: Colors.transparent,
                              );
                            } else if (state is MovieProvidersLoading) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.transparent,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFFF5046),
                                  ),
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
                                                color: Colors.transparent,
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
                                color: Colors.transparent,
                                child: Center(
                                    child: Text(
                                  state.error!.message!,
                                  style: TextStyle(color: Colors.white),
                                )),
                              );
                            } else {
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.transparent,
                                child: const Center(
                                    child: Text("Something went wrong!")),
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
                        const Text(
                          "More Like This",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
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
                                color: Colors.transparent,
                              );
                            } else if (state is SimilarMoviesLoading) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.transparent,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFFF5046),
                                  ),
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
                                                          ],
                                                          child:
                                                              MovieDetailScreen(
                                                                  movie: e),
                                                        )));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.23,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color: Colors.transparent,
                                                  image: DecorationImage(
                                                      image: CachedNetworkImageProvider(
                                                          "https://image.tmdb.org/t/p/w200/${e.posterPath}"))),
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
                                color: Colors.transparent,
                                child: Center(
                                    child: Text(
                                  state.error!.message!,
                                  style: TextStyle(color: Colors.white),
                                )),
                              );
                            } else {
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.transparent,
                                child: const Center(
                                    child: Text("Something went wrong!")),
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

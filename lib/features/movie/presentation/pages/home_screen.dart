import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/all_popular/all_popular_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/all_top/all_top_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_state.dart';
import 'package:moviki/features/movie/presentation/bloc/favorite_movie/favorite_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/favorite_movie/favorite_movie_state.dart';
import 'package:moviki/features/movie/presentation/bloc/popular_movie/remote/remote_popular_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/popular_movie/remote/remote_popular_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/popular_movie/remote/remote_popular_movie_state.dart';
import 'package:moviki/features/movie/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/search_movie/search_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/search_movie/search_movie_state.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_state.dart';
import 'package:moviki/features/movie/presentation/pages/movie_list_screen.dart';
import 'package:moviki/features/movie/presentation/widgets/custom_list_card.dart';
import 'package:moviki/features/movie/presentation/widgets/custom_slider.dart';
import 'package:moviki/features/movie/presentation/widgets/custom_top_slider.dart';
import 'package:moviki/injection_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.currentIndex,
          onTap: (value) {
            context.read<BottomNavigationBloc>().add(ChangePage(value));
          },
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white54,
          selectedItemColor: const Color(0xFFFF5046),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                    state.currentIndex == 0 ? Icons.home : Icons.home_outlined),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(state.currentIndex == 1
                    ? Icons.favorite
                    : Icons.favorite_outline),
                label: "Favorite"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined), label: "Search"),
          ],
        ),
        backgroundColor: Colors.black,
        body: state.currentIndex == 0
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    BlocBuilder<RemotePopularMovieBloc,
                        RemotePopularMovieState>(
                      builder: (context, state) {
                        if (state is RemotePopularMovieInitial) {
                          context
                              .read<RemotePopularMovieBloc>()
                              .add(GetPopularMovies());
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.65,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                          );
                        } else if (state is RemotePopularMovieLoading) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.65,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFFF5046),
                              ),
                            ),
                          );
                        } else if (state is RemotePopularMovieLoaded) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.60,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: CustomTopSlider(
                              movieList: state.movies!.sublist(0, 3),
                            ),
                          );
                        } else {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.65,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: const Center(
                                child: Text("Something went wrong!")),
                          );
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Top Movies",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BlocProvider<AllPopularBloc>.value(
                                          value: getIt(),
                                          child: const MovieListScreen(
                                              title: "Top Movies"),
                                        )));
                          },
                          child: const Row(
                            children: [
                              Text(
                                "See All",
                                style: TextStyle(
                                    color: Color(0xFFFF5046), fontSize: 16),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFFFF5046),
                                size: 16,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    BlocBuilder<RemotePopularMovieBloc,
                        RemotePopularMovieState>(
                      builder: (context, state) {
                        if (state is RemotePopularMovieInitial) {
                          context
                              .read<RemotePopularMovieBloc>()
                              .add(GetPopularMovies());
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.22,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                          );
                        } else if (state is RemotePopularMovieLoading) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.22,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFFF5046),
                              ),
                            ),
                          );
                        } else if (state is RemotePopularMovieLoaded) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.22,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: CustomSlider(
                              movieList: state.movies!.sublist(3),
                            ),
                          );
                        } else {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.22,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: const Center(
                                child: Text("Something went wrong!")),
                          );
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Top Rated",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BlocProvider<AllTopBloc>.value(
                                          value: getIt(),
                                          child: const MovieListScreen(
                                              title: "Top Rated"),
                                        )));
                          },
                          child: const Row(
                            children: [
                              Text(
                                "See All",
                                style: TextStyle(
                                    color: Color(0xFFFF5046), fontSize: 16),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFFFF5046),
                                size: 16,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    BlocBuilder<RemoteTopMovieBloc, RemoteTopMovieState>(
                      builder: (context, state) {
                        if (state is RemoteTopMovieInitial) {
                          context
                              .read<RemoteTopMovieBloc>()
                              .add(GetTopRatedMovies());
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.22,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                          );
                        } else if (state is RemoteTopMovieLoading) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.22,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFFFF5046),
                              ),
                            ),
                          );
                        } else if (state is RemoteTopMovieLoaded) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.22,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: CustomSlider(
                              movieList: state.movies!,
                            ),
                          );
                        } else {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.22,
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
              )
            : state.currentIndex == 1
                ? BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
                    builder: (context, state) {
                      if (state is FavoriteMovieLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFFF5046),
                          ),
                        );
                      } else if (state is FavoriteMovieLoaded) {
                        if (state.movies != null) {
                          return state.movies!.isEmpty
                              ? const Center(
                                  child: Text(
                                    "There is no fav movie!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.transparent,
                                  child: ListView.builder(
                                    itemCount: state.movies!.length,
                                    itemBuilder: (context, index) {
                                      return CustomListCard(
                                          movie: state.movies![index]);
                                    },
                                  ));
                        } else {
                          return const Center(
                            child: Text(
                              "There is no fav movie!",
                              style: TextStyle(color: Colors.white38),
                            ),
                          );
                        }
                      } else {
                        return const Center(
                          child: Text("Something went wrong!"),
                        );
                      }
                    },
                  )
                : Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.032,
                          left: 8,
                          right: 8,
                        ),
                        child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) {
                            context
                                .read<SearchMovieBloc>()
                                .add(SearchMovies(query: value));
                          },
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white12,
                              hintText: 'Search Movie...',
                              hintStyle: TextStyle(color: Colors.white38),
                              suffixIcon: Icon(Icons.search),
                              suffixIconColor: Color(0xFFFF5046),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 2.0,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24)))),
                        ),
                      ),
                      BlocBuilder<SearchMovieBloc, SearchMovieState>(
                        builder: (context, state) {
                          if (state is SearchMovieLoaded) {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: state.movies!.length,
                                itemBuilder: (context, index) {
                                  return CustomListCard(
                                      movie: state.movies![index]);
                                },
                              ),
                            );
                          } else if (state is SearchMovieError) {
                            return const Center(
                              child: Text("Something went wrong!"),
                            );
                          } else {
                            return Container();
                          }
                        },
                      )
                    ],
                  ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/config/theme/app_color.dart';
import 'package:moviki/config/theme/app_theme.dart';
import 'package:moviki/features/country/presentation/pages/country_screen.dart';
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
import 'package:moviki/features/movie/presentation/pages/about_screen.dart';
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
            items: [
              BottomNavigationBarItem(
                  icon: Icon(state.currentIndex == 0
                      ? Icons.home
                      : Icons.home_outlined),
                  label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(state.currentIndex == 1
                      ? Icons.favorite
                      : Icons.favorite_outline),
                  label: "Favorite"),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(state.currentIndex == 3
                      ? Icons.settings
                      : Icons.settings_outlined),
                  label: "Settings"),
            ],
          ),
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
                              color: AppColor.transparent,
                            );
                          } else if (state is RemotePopularMovieLoading) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.65,
                              width: MediaQuery.of(context).size.width,
                              color: AppColor.transparent,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is RemotePopularMovieLoaded) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.60,
                              width: MediaQuery.of(context).size.width,
                              color: AppColor.transparent,
                              child: CustomTopSlider(
                                movieList: state.movies!.sublist(0, 3),
                              ),
                            );
                          } else {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.65,
                              width: MediaQuery.of(context).size.width,
                              color: AppColor.transparent,
                              child: const Center(
                                  child: Text("Something went wrong!")),
                            );
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top Movies",
                            style: AppTheme.theme.textTheme.titleMedium!
                                .copyWith(color: AppColor.labelOne),
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
                            child: Row(
                              children: [
                                Text(
                                  "See All",
                                  style: AppTheme.theme.textTheme.titleMedium!
                                      .copyWith(color: AppColor.primary),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColor.primary,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.22,
                                width: MediaQuery.of(context).size.width,
                                color: AppColor.transparent);
                          } else if (state is RemotePopularMovieLoading) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.22,
                              width: MediaQuery.of(context).size.width,
                              color: AppColor.transparent,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is RemotePopularMovieLoaded) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.22,
                              width: MediaQuery.of(context).size.width,
                              color: AppColor.transparent,
                              child: CustomSlider(
                                movieList: state.movies!.sublist(3),
                              ),
                            );
                          } else {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.22,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Top Rated",
                            style: AppTheme.theme.textTheme.titleMedium!
                                .copyWith(color: AppColor.labelOne),
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
                            child: Row(
                              children: [
                                Text(
                                  "See All",
                                  style: AppTheme.theme.textTheme.titleMedium!
                                      .copyWith(color: AppColor.primary),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColor.primary,
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
                              color: AppColor.transparent,
                            );
                          } else if (state is RemoteTopMovieLoading) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.22,
                              width: MediaQuery.of(context).size.width,
                              color: AppColor.transparent,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is RemoteTopMovieLoaded) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.22,
                              width: MediaQuery.of(context).size.width,
                              color: AppColor.transparent,
                              child: CustomSlider(
                                movieList: state.movies!,
                              ),
                            );
                          } else {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.22,
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
                )
              : state.currentIndex == 1
                  ? BlocBuilder<FavoriteMovieBloc, FavoriteMovieState>(
                      builder: (context, state) {
                        if (state is FavoriteMovieLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is FavoriteMovieLoaded) {
                          if (state.movies != null) {
                            return state.movies!.isEmpty
                                ? Center(
                                    child: Text(
                                      "There is no fav movie!",
                                      style:
                                          AppTheme.theme.textTheme.titleLarge,
                                    ),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    color: AppColor.transparent,
                                    child: ListView.builder(
                                      itemCount: state.movies!.length,
                                      itemBuilder: (context, index) {
                                        return CustomListCard(
                                            movie: state.movies![index]);
                                      },
                                    ));
                          } else {
                            return Center(
                              child: Text(
                                "There is no fav movie!",
                                style: AppTheme.theme.textTheme.titleLarge,
                              ),
                            );
                          }
                        } else {
                          return Center(
                            child: Text(
                              "Something went wrong!",
                              style: AppTheme.theme.textTheme.titleLarge,
                            ),
                          );
                        }
                      },
                    )
                  : state.currentIndex == 2
                      ? Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.032,
                                left: 8,
                                right: 8,
                              ),
                              child: TextFormField(
                                style: AppTheme.theme.textTheme.titleLarge,
                                onChanged: (value) {
                                  context
                                      .read<SearchMovieBloc>()
                                      .add(SearchMovies(query: value));
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search Movie...',
                                  suffixIcon: Icon(Icons.search),
                                ).applyDefaults(
                                    AppTheme.theme.inputDecorationTheme),
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
                        )
                      : ListView(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CountryScreen(),
                                    ));
                              },
                              leading: const Icon(
                                Icons.language,
                                color: AppColor.primary,
                              ),
                              title: Text(
                                "Change Country",
                                style: AppTheme.theme.textTheme.titleMedium,
                              ),
                            ),
                            const Divider(),
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AboutScreen(),
                                    ));
                              },
                              leading: const Icon(
                                Icons.info,
                                color: AppColor.primary,
                              ),
                              title: Text(
                                "About",
                                style: AppTheme.theme.textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_state.dart';
import 'package:moviki/features/movie/presentation/bloc/movie/remote/remote_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie/remote/remote_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/movie/remote/remote_movie_state.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_state.dart';
import 'package:moviki/features/movie/presentation/pages/movie_list_screen.dart';
import 'package:moviki/features/movie/presentation/widgets/custom_slider.dart';
import 'package:moviki/features/movie/presentation/widgets/custom_top_slider.dart';

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
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline), label: "Favorite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined), label: "Search"),
          ],
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<RemoteMovieBloc, RemoteMovieState>(
                builder: (context, state) {
                  if (state is RemoteMovieInitial) {
                    context.read<RemoteMovieBloc>().add(GetPopularMovies());
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                    );
                  } else if (state is RemoteMovieLoading) {
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
                  } else if (state is RemoteMovieLoaded) {
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
                      child: const Center(child: Text("Something went wrong!")),
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
                                const MovieListScreen(title: "Top Movies"),
                          ));
                    },
                    child: const Row(
                      children: [
                        Text(
                          "See All",
                          style:
                              TextStyle(color: Color(0xFFFF5046), fontSize: 16),
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
              BlocBuilder<RemoteMovieBloc, RemoteMovieState>(
                builder: (context, state) {
                  if (state is RemoteMovieInitial) {
                    context.read<RemoteMovieBloc>().add(GetPopularMovies());
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                    );
                  } else if (state is RemoteMovieLoading) {
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
                  } else if (state is RemoteMovieLoaded) {
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
                      child: const Center(child: Text("Something went wrong!")),
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
                                const MovieListScreen(title: "Top Rated"),
                          ));
                    },
                    child: const Row(
                      children: [
                        Text(
                          "See All",
                          style:
                              TextStyle(color: Color(0xFFFF5046), fontSize: 16),
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
                    context.read<RemoteTopMovieBloc>().add(GetTopRatedMovies());
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
                      child: const Center(child: Text("Something went wrong!")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

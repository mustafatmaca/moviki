import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie/remote/remote_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/movie/remote/remote_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/movie/remote/remote_movie_state.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_state.dart';
import 'package:moviki/features/movie/presentation/widgets/custom_list_card.dart';

class MovieListScreen extends StatelessWidget {
  final String title;
  const MovieListScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(title),
          centerTitle: false,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: buildList(title));
  }

  buildList(String title) {
    if (title == "Top Movies") {
      return BlocBuilder<RemoteMovieBloc, RemoteMovieState>(
        builder: (context, state) {
          if (state is RemoteMovieInitial) {
            context.read<RemoteMovieBloc>().add(const GetPopularMovies());
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            );
          } else if (state is RemoteMovieLoading) {
            return Container(
              height: MediaQuery.of(context).size.height,
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
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: ListView.builder(
                  itemCount: state.movies!.length,
                  itemBuilder: (context, index) {
                    return CustomListCard(movie: state.movies![index]);
                  },
                ));
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: const Center(child: Text("Something went wrong!")),
            );
          }
        },
      );
    } else if (title == "Top Rated") {
      return BlocBuilder<RemoteTopMovieBloc, RemoteTopMovieState>(
        builder: (context, state) {
          if (state is RemoteTopMovieInitial) {
            context.read<RemoteTopMovieBloc>().add(const GetTopRatedMovies());
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            );
          } else if (state is RemoteTopMovieLoading) {
            return Container(
              height: MediaQuery.of(context).size.height,
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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: ListView.builder(
                itemCount: state.movies!.length,
                itemBuilder: (context, index) {
                  return CustomListCard(movie: state.movies![index]);
                },
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: const Center(child: Text("Something went wrong!")),
            );
          }
        },
      );
    }
  }
}

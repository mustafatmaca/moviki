import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/all_popular/all_popular_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/all_popular/all_popular_event.dart';
import 'package:moviki/features/movie/presentation/bloc/all_popular/all_popular_state.dart';
import 'package:moviki/features/movie/presentation/bloc/all_top/all_top_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/all_top/all_top_event.dart';
import 'package:moviki/features/movie/presentation/bloc/all_top/all_top_state.dart';
import 'package:moviki/features/movie/presentation/widgets/custom_list_card.dart';

class MovieListScreen extends StatefulWidget {
  final String title;
  const MovieListScreen({super.key, required this.title});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  late ScrollController scrollController;
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()..addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter == 0) {
      setState(() {
        isLoading = true;
      });
      page++;
      await new Future.delayed(const Duration(seconds: 2));
      context.read<AllPopularBloc>().add(GetAllPopularMovies(page: page));
      await new Future.delayed(const Duration(seconds: 2));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: false,
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false,
        ),
        body: buildList(widget.title, page));
  }

  buildList(String title, int page) {
    if (title == "Top Movies") {
      return BlocBuilder<AllPopularBloc, AllPopularState>(
        builder: (context, state) {
          if (state is AllPopularInitial) {
            context.read<AllPopularBloc>().add(GetAllPopularMovies(page: page));
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            );
          } else if (state is AllPopularLoading) {
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
          } else if (state is AllPopularLoaded) {
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: state.movies!.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.movies!.length) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFFF5046),
                          ),
                        ),
                      );
                    } else {
                      return CustomListCard(movie: state.movies![index]);
                    }
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
      return BlocBuilder<AllTopBloc, AllTopState>(
        builder: (context, state) {
          if (state is AllTopInitial) {
            context.read<AllTopBloc>().add(const GetAllTopRatedMovies());
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            );
          } else if (state is AllTopLoading) {
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
          } else if (state is AllTopLoaded) {
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

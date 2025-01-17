import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/config/theme/app_color.dart';
import 'package:moviki/config/theme/app_theme.dart';
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
    if (scrollController.position.extentAfter == 0 && !isLoading) {
      setState(() {
        isLoading = true;
      });
      page++;
      await Future.delayed(const Duration(milliseconds: 500));
      if (widget.title == "Top Movies") {
        context.read<AllPopularBloc>().add(GetAllPopularMovies(page: page));
      }
      if (widget.title == "Top Rated") {
        context.read<AllTopBloc>().add(GetAllTopRatedMovies(page: page));
      }

      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        setState(() {
          page = 1;
        });
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            automaticallyImplyLeading: false,
          ),
          body: buildList(widget.title, page)),
    );
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
              color: AppColor.transparent,
            );
          } else if (state is AllPopularLoading) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: AppColor.transparent,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AllPopularLoaded) {
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: AppColor.transparent,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: state.movies!.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.movies!.length) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 14.0),
                        child: Center(
                          child: CircularProgressIndicator(),
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
              color: AppColor.transparent,
              child: Center(
                  child: Text(
                "Something went wrong!",
                style: AppTheme.theme.textTheme.titleLarge,
              )),
            );
          }
        },
      );
    } else if (title == "Top Rated") {
      return BlocBuilder<AllTopBloc, AllTopState>(
        builder: (context, state) {
          if (state is AllTopInitial) {
            context.read<AllTopBloc>().add(GetAllTopRatedMovies(page: page));
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: AppColor.transparent,
            );
          } else if (state is AllTopLoading) {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: AppColor.transparent,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AllTopLoaded) {
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: AppColor.transparent,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: state.movies!.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == state.movies!.length) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 14.0),
                        child: Center(
                          child: CircularProgressIndicator(),
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
              color: AppColor.transparent,
              child: Center(
                  child: Text(
                "Something went wrong!",
                style: AppTheme.theme.textTheme.titleLarge,
              )),
            );
          }
        },
      );
    }
  }
}

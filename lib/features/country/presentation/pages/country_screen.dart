import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/config/theme/app_color.dart';
import 'package:moviki/config/theme/app_theme.dart';
import 'package:moviki/features/country/domain/usecases/set_country.dart';
import 'package:moviki/features/country/presentation/bloc/country/country_bloc.dart';
import 'package:moviki/features/country/presentation/bloc/country/country_state.dart';
import 'package:moviki/features/movie/presentation/bloc/popular_movie/remote/remote_popular_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/popular_movie/remote/remote_popular_movie_event.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/top_movie/remote/remote_top_movie_event.dart';
import 'package:moviki/injection_container.dart';

class CountryScreen extends StatelessWidget {
  const CountryScreen({Key? key}) : super(key: key);

  void setCountry(String country) async {
    getIt<SetCountryUseCase>().call(params: country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Country"),
      ),
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryLoaded) {
            return ListView.builder(
              itemCount: state.countries!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Change Country"),
                          content: Text(
                              "Your country setting wil be change to this: ${state.countries![index].englishName}"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Cancel",
                                  style: AppTheme.theme.textTheme.titleSmall,
                                )),
                            TextButton(
                                onPressed: () {
                                  setCountry(state.countries![index].iso31661!);
                                  context
                                      .read<RemotePopularMovieBloc>()
                                      .add(const GetPopularMovies());
                                  context
                                      .read<RemoteTopMovieBloc>()
                                      .add(const GetTopRatedMovies());
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "OK",
                                  style: AppTheme.theme.textTheme.titleSmall!
                                      .copyWith(color: AppColor.primary),
                                ))
                          ],
                        );
                      },
                    );
                  },
                  leading: Text(
                    state.countries![index].iso31661!,
                    style: AppTheme.theme.textTheme.bodyLarge!
                        .copyWith(color: AppColor.labelTwo),
                  ),
                  title: Text(
                    state.countries![index].englishName!,
                    style: AppTheme.theme.textTheme.bodyLarge!
                        .copyWith(color: AppColor.labelTwo),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                "Something went wrong!",
                style: AppTheme.theme.textTheme.titleLarge,
              ),
            );
          }
        },
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/config/theme/app_color.dart';
import 'package:moviki/config/theme/app_theme.dart';
import 'package:moviki/features/movie/presentation/pages/home_screen.dart';
import 'package:moviki/features/splash/domain/usecases/set_country.dart';
import 'package:moviki/features/splash/domain/usecases/set_is_open.dart';
import 'package:moviki/features/splash/presentation/bloc/country/country_bloc.dart';
import 'package:moviki/features/splash/presentation/bloc/country/country_state.dart';
import 'package:moviki/features/splash/presentation/bloc/select_country/select_country_bloc.dart';
import 'package:moviki/features/splash/presentation/bloc/select_country/select_country_event.dart';
import 'package:moviki/features/splash/presentation/bloc/select_country/select_country_state.dart';
import 'package:moviki/injection_container.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  void changeIsOpen() async {
    getIt<SetIsOpenUseCase>().call(params: true);
  }

  void setCountry(String country) async {
    getIt<SetCountryUseCase>().call(params: country);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: AppColor.background,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/splash_bg.png"))),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  color: AppColor.blur,
                ),
              ),
            ),
          ),
          Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
                height: MediaQuery.of(context).size.height * 0.38,
                width: MediaQuery.of(context).size.width,
                child: BlocBuilder<SelectCountryBloc, SelectCountryState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Moviki",
                            style: AppTheme.theme.textTheme.displayLarge),
                        Text("Get knowledge about films and series!",
                            style: AppTheme.theme.textTheme.headlineSmall!
                                .copyWith(color: AppColor.labelOne)),
                        OutlinedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor: AppColor.background,
                                showDragHandle: true,
                                context: context,
                                builder: (context) {
                                  return BlocBuilder<CountryBloc, CountryState>(
                                    builder: (context, state) {
                                      if (state is CountryLoaded) {
                                        return ListView.builder(
                                          itemCount: state.countries!.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              onTap: () {
                                                context
                                                    .read<SelectCountryBloc>()
                                                    .add(SelectCountry(state
                                                        .countries![index]));
                                                Navigator.pop(context);
                                              },
                                              leading: Text(
                                                state.countries![index]
                                                    .iso31661!,
                                                style: AppTheme
                                                    .theme.textTheme.bodyLarge!
                                                    .copyWith(
                                                        color:
                                                            AppColor.labelTwo),
                                              ),
                                              title: Text(
                                                state.countries![index]
                                                    .englishName!,
                                                style: AppTheme
                                                    .theme.textTheme.bodyLarge!
                                                    .copyWith(
                                                        color:
                                                            AppColor.labelTwo),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return Center(
                                          child: Text(
                                            "Something went wrong!",
                                            style: AppTheme
                                                .theme.textTheme.titleLarge,
                                          ),
                                        );
                                      }
                                    },
                                  );
                                },
                              );
                            },
                            style: AppTheme.theme.outlinedButtonTheme.style!
                                .copyWith(
                              minimumSize: WidgetStatePropertyAll(
                                Size(MediaQuery.of(context).size.width,
                                    MediaQuery.of(context).size.height * 0.07),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                state is SelectCountryLoaded
                                    ? Text(
                                        "${state.selectedCountry!.iso31661} - ${state.selectedCountry!.englishName}",
                                        style: AppTheme
                                            .theme.textTheme.bodyLarge!
                                            .copyWith(
                                          color: AppColor.labelTwo,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    : Text(
                                        "Select Country",
                                        style: AppTheme
                                            .theme.textTheme.bodyLarge!
                                            .copyWith(
                                          color: AppColor.labelTwo,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size:
                                      MediaQuery.of(context).size.width * 0.04,
                                  color: AppColor.labelTwo,
                                )
                              ],
                            )),
                        ElevatedButton(
                          onPressed: () {
                            changeIsOpen();
                            if (state is SelectCountryLoaded) {
                              setCountry(state.selectedCountry!.iso31661!);
                            }
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          },
                          style: AppTheme.theme.elevatedButtonTheme.style!
                              .copyWith(
                                  minimumSize: WidgetStateProperty.all(Size(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height *
                                          0.07))),
                          child: Text(
                            "Get Started",
                            style: AppTheme.theme.textTheme.titleMedium!
                                .copyWith(color: AppColor.labelOne),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ))
        ],
      ),
    );
  }
}

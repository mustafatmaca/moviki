import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            color: Colors.black,
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
                  color: Colors.black54,
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
                        const Text(
                          "Moviki",
                          style: TextStyle(color: Colors.white, fontSize: 36),
                        ),
                        const Text(
                          "Get knowledge about films and series!",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        OutlinedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.black,
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
                                                style: const TextStyle(
                                                    color: Colors.white60),
                                              ),
                                              title: Text(
                                                state.countries![index]
                                                    .englishName!,
                                                style: const TextStyle(
                                                    color: Colors.white60),
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        return const Center(
                                          child: Text("Something went wrong!"),
                                        );
                                      }
                                    },
                                  );
                                },
                              );
                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white60,
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width,
                                    MediaQuery.of(context).size.height * 0.07)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                state is SelectCountryLoaded
                                    ? Text(
                                        "${state.selectedCountry!.iso31661} - ${state.selectedCountry!.englishName}",
                                        style: const TextStyle(
                                            color: Colors.white60),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : const Text(
                                        "Select Country",
                                        style: TextStyle(color: Colors.white60),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size:
                                      MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.white60,
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
                          style: ElevatedButton.styleFrom(
                              elevation: 12,
                              backgroundColor: const Color(0xFFFF5046),
                              foregroundColor: Colors.white,
                              shadowColor: const Color(0xFFFF5046),
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.height * 0.07)),
                          child: const Text("Get Started"),
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

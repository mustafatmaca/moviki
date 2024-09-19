import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/movie/presentation/pages/home_screen.dart';
import 'package:moviki/features/splash/presentation/bloc/country/country_bloc.dart';
import 'package:moviki/features/splash/presentation/bloc/country/country_event.dart';
import 'package:moviki/features/splash/presentation/bloc/country/country_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  void changeIsOpen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isOpen', true);
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
                child: Column(
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
                    BlocBuilder<CountryBloc, CountryState>(
                      builder: (context, state) {
                        if (state is CountryLoaded) {
                          return OutlinedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return ListView.builder(
                                      itemCount: state.countries!.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            context.read<CountryBloc>().add(
                                                SelectCountry(
                                                    state.countries![index]));
                                          },
                                          leading: Text(state
                                              .countries![index].iso31661!),
                                          title: Text(state
                                              .countries![index].englishName!),
                                          trailing: state.countries![index] ==
                                                  state.selectedCountry
                                              ? const Icon(Icons.check)
                                              : null,
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height *
                                          0.07)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${state.selectedCountry!.iso31661} - ${state.selectedCountry!.englishName}",
                                    style: const TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: MediaQuery.of(context).size.width *
                                        0.04,
                                  )
                                ],
                              ));
                        } else if (state is CountryError) {
                          return OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height *
                                          0.07)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Something went wrong!",
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: MediaQuery.of(context).size.width *
                                        0.04,
                                  )
                                ],
                              ));
                        } else {
                          return OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width,
                                      MediaQuery.of(context).size.height *
                                          0.07)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Country",
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: MediaQuery.of(context).size.width *
                                        0.04,
                                  )
                                ],
                              ));
                        }
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        changeIsOpen();
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
                          minimumSize: Size(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height * 0.07)),
                      child: const Text("Get Started"),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

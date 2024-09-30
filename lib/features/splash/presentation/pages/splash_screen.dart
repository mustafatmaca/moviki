import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moviki/config/theme/app_color.dart';
import 'package:moviki/features/country/presentation/widgets/splash_content.dart';
import 'package:moviki/features/splash/domain/usecases/set_is_open.dart';
import 'package:moviki/injection_container.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  void changeIsOpen() async {
    getIt<SetIsOpenUseCase>().call(params: true);
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
              child: SplashContent(changeIsOpen: changeIsOpen))
        ],
      ),
    );
  }
}

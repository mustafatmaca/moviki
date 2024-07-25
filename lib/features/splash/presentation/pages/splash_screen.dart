import 'dart:ui';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
                padding: EdgeInsets.only(left: 12, right: 12, bottom: 24),
                height: MediaQuery.of(context).size.height * 0.38,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Moviki",
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                    Text(
                      "Get knowledge about films and series!",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Get Started"),
                      style: ElevatedButton.styleFrom(
                          elevation: 12,
                          backgroundColor: Color(0xFFFF5046),
                          foregroundColor: Colors.white,
                          shadowColor: Color(0xFFFF5046),
                          minimumSize: Size(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height * 0.07)),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

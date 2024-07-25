import 'package:flutter/material.dart';
import 'package:moviki/features/splash/presentation/pages/splash_screen.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Moviki',
    home: SplashScreen(),
  ));
}

import 'package:flutter/material.dart';
import 'package:moviki/config/theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Moviki App®", style: AppTheme.theme.textTheme.displaySmall),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Text(
            "This product uses the TMDB API but is not endorsed or certified by TMDB.",
            style: AppTheme.theme.textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Image.asset(
            "assets/images/tmdb_logo.png",
            width: MediaQuery.of(context).size.width * 0.2,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_state.dart';
import 'package:moviki/features/movie/presentation/widgets/custom_slider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
        builder: (context, state) {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.currentIndex,
          onTap: (value) {
            context.read<BottomNavigationBloc>().add(ChangePage(value));
          },
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white54,
          selectedItemColor: const Color(0xFFFF5046),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline), label: "Favorite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined), label: "Search"),
          ],
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.65,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Top Movies",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Text(
                          "See All",
                          style:
                              TextStyle(color: Color(0xFFFF5046), fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFFF5046),
                          size: 16,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: CustomSlider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Now In Theatre",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Text(
                          "See All",
                          style:
                              TextStyle(color: Color(0xFFFF5046), fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFFF5046),
                          size: 16,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              ),
            ],
          ),
        ),
      );
    });
  }
}

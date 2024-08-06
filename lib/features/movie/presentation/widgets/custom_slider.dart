import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final PageController _pageController = PageController(viewportFraction: 0.9);

  final List tempList = List.generate(20, (index) {
    return Expanded(
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(4.0),
        color: Colors.primaries[index % Colors.primaries.length],
        child: Center(
          child: Text(
            'Container ${index + 1}',
            style: const TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  });

  CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, pageIndex) {
        return Row(children: [
          tempList[pageIndex * 3],
          tempList[pageIndex * 3 + 1],
          tempList[pageIndex * 3 + 2],
        ]);
      },
      itemCount:
          tempList.length ~/ 3, // Adjust this to the total number of pages
    );
  }
}

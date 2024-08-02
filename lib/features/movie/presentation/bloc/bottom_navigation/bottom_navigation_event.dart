import 'package:equatable/equatable.dart';

abstract class BottomNavigationEvent extends Equatable {
  final int currentIndex;

  const BottomNavigationEvent(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

class ChangePage extends BottomNavigationEvent {
  const ChangePage(super.currentIndex);
}

import 'package:equatable/equatable.dart';

abstract class BottomNavigationState extends Equatable {
  final int currentIndex;

  const BottomNavigationState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

final class PageChanged extends BottomNavigationState {
  const PageChanged(super.currentIndex);
}

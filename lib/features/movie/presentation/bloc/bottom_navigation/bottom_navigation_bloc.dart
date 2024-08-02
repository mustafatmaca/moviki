import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_event.dart';
import 'package:moviki/features/movie/presentation/bloc/bottom_navigation/bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(const PageChanged(0)) {
    on<ChangePage>(onChangePage);
  }

  FutureOr<void> onChangePage(
      ChangePage event, Emitter<BottomNavigationState> emit) {
    emit(PageChanged(event.currentIndex));
  }
}

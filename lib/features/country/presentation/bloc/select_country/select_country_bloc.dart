import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviki/features/country/presentation/bloc/select_country/select_country_event.dart';
import 'package:moviki/features/country/presentation/bloc/select_country/select_country_state.dart';

class SelectCountryBloc extends Bloc<SelectCountryEvent, SelectCountryState> {
  SelectCountryBloc() : super(SelectCountryInitial()) {
    on<SelectCountry>(onSelectCountry);
  }

  FutureOr<void> onSelectCountry(
      SelectCountry event, Emitter<SelectCountryState> emit) async {
    if (state is SelectCountryLoaded) {
      if (state.selectedCountry != event.selectedCountry) {
        emit(SelectCountryLoaded(event.selectedCountry!));
      }
    } else {
      emit(SelectCountryLoaded(event.selectedCountry!));
    }
  }
}

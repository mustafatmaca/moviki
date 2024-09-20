import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/splash/domain/usecases/get_countries.dart';
import 'package:moviki/features/splash/presentation/bloc/country/country_event.dart';
import 'package:moviki/features/splash/presentation/bloc/country/country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final GetCountriesUseCase _getCountriesUseCase;
  CountryBloc(this._getCountriesUseCase) : super(const CountryInitial()) {
    on<GetCountries>(onGetCountries);
  }

  Future<void> onGetCountries(
      GetCountries event, Emitter<CountryState> emit) async {
    emit(const CountryLoading());

    final dataState = await _getCountriesUseCase();

    if (dataState is DataSuccess) {
      emit(CountryLoaded(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(CountryError(dataState.error!));
    }
  }
}

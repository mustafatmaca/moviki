import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:moviki/features/splash/domain/entities/country.dart';

abstract class CountryState extends Equatable {
  final List<CountryEntity>? countries;
  final CountryEntity? selectedCountry;
  final DioException? error;
  const CountryState({this.countries, this.selectedCountry, this.error});

  @override
  List<Object> get props => [countries!, selectedCountry!, error!];
}

final class CountryInitial extends CountryState {
  const CountryInitial();
}

final class CountryLoading extends CountryState {
  const CountryLoading();
}

final class CountryLoaded extends CountryState {
  const CountryLoaded(
      List<CountryEntity>? countries, CountryEntity? selectedCountry)
      : super(
          countries: countries,
          selectedCountry: selectedCountry,
        );
}

final class CountryError extends CountryState {
  const CountryError(DioException error) : super(error: error);
}

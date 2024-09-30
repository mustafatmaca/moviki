import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:moviki/features/country/domain/entities/country.dart';

abstract class CountryState extends Equatable {
  final List<CountryEntity>? countries;
  final DioException? error;
  const CountryState({this.countries, this.error});

  @override
  List<Object> get props => [countries!, error!];
}

final class CountryInitial extends CountryState {
  const CountryInitial();
}

final class CountryLoading extends CountryState {
  const CountryLoading();
}

final class CountryLoaded extends CountryState {
  const CountryLoaded(List<CountryEntity> countries)
      : super(countries: countries);
}

final class CountryError extends CountryState {
  const CountryError(DioException error) : super(error: error);
}

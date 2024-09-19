import 'package:equatable/equatable.dart';
import 'package:moviki/features/splash/domain/entities/country.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object> get props => [];
}

class GetCountries extends CountryEvent {
  const GetCountries();
}

class SelectCountry extends CountryEvent {
  final CountryEntity selectedCountry;

  const SelectCountry(this.selectedCountry);

  @override
  List<Object> get props => [selectedCountry];
}

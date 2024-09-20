import 'package:equatable/equatable.dart';
import 'package:moviki/features/splash/domain/entities/country.dart';

abstract class SelectCountryState extends Equatable {
  final CountryEntity? selectedCountry;

  const SelectCountryState({this.selectedCountry});

  @override
  List<Object> get props => [selectedCountry!];
}

final class SelectCountryInitial extends SelectCountryState {
  const SelectCountryInitial();
}

final class SelectCountryLoading extends SelectCountryState {
  const SelectCountryLoading();
}

final class SelectCountryLoaded extends SelectCountryState {
  const SelectCountryLoaded(CountryEntity selectedCountry)
      : super(selectedCountry: selectedCountry);
}

final class SelectCountryError extends SelectCountryState {
  const SelectCountryError();
}

import 'package:equatable/equatable.dart';
import 'package:moviki/features/country/domain/entities/country.dart';

abstract class SelectCountryEvent extends Equatable {
  final CountryEntity? selectedCountry;

  const SelectCountryEvent({this.selectedCountry});

  @override
  List<Object> get props => [selectedCountry!];
}

class SelectCountry extends SelectCountryEvent {
  SelectCountry(CountryEntity selectedCountry)
      : super(selectedCountry: selectedCountry);

  @override
  List<Object> get props => [selectedCountry!];
}

import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/country/domain/entities/country.dart';
import 'package:moviki/features/country/domain/repository/country_repository.dart';

class GetCountriesUseCase
    implements UseCase<DataState<List<CountryEntity>>, void> {
  final CountryRepository _countryRepository;

  GetCountriesUseCase(this._countryRepository);

  @override
  Future<DataState<List<CountryEntity>>> call({void params}) {
    return _countryRepository.getCountries();
  }
}

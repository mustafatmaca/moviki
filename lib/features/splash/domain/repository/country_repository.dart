import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/features/splash/domain/entities/country.dart';

abstract class CountryRepository {
  Future<DataState<List<CountryEntity>>> getCountries();
}

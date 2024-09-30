import 'package:moviki/features/country/domain/repository/country_shared_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountrySharedRepositoryImpl implements CountrySharedRepository {
  final SharedPreferences _prefs;

  CountrySharedRepositoryImpl(this._prefs);

  @override
  String? getCountry() {
    return _prefs.getString('country');
  }

  @override
  void setCountry(String country) {
    _prefs.setString('country', country);
  }
}

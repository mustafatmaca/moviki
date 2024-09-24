import 'package:moviki/features/splash/domain/repository/shared_prefs_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepositoryImpl implements SharedPrefsRepository {
  final SharedPreferences _prefs;

  SharedPrefsRepositoryImpl(this._prefs);

  @override
  String? getCountry() {
    return _prefs.getString('country');
  }

  @override
  bool? getIsOpen() {
    return _prefs.getBool('isOpen');
  }

  @override
  void setCountry(String country) {
    _prefs.setString('country', country);
  }

  @override
  void setIsOpen(bool isOpen) {
    _prefs.setBool('isOpen', isOpen);
  }
}

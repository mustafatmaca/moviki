import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/splash/domain/repository/shared_prefs_repository.dart';

class GetCountryUseCase implements UseCase<String?, void> {
  final SharedPrefsRepository _sharedPrefsRepository;

  GetCountryUseCase(this._sharedPrefsRepository);

  @override
  Future<String?> call({void params}) async {
    return _sharedPrefsRepository.getCountry();
  }
}

import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/splash/domain/repository/shared_prefs_repository.dart';

class SetCountryUseCase implements UseCase<void, String> {
  final SharedPrefsRepository _sharedPrefsRepository;

  SetCountryUseCase(this._sharedPrefsRepository);

  @override
  Future<void> call({String? params}) async {
    return _sharedPrefsRepository.setCountry(params!);
  }
}

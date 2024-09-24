import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/splash/domain/repository/shared_prefs_repository.dart';

class GetIsOpenUseCase implements UseCase<bool?, void> {
  final SharedPrefsRepository _sharedPrefsRepository;

  GetIsOpenUseCase(this._sharedPrefsRepository);

  @override
  Future<bool?> call({void params}) async {
    return _sharedPrefsRepository.getIsOpen();
  }
}

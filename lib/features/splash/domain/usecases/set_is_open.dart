import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/splash/domain/repository/shared_prefs_repository.dart';

class SetIsOpenUseCase implements UseCase<void, bool> {
  final SharedPrefsRepository _sharedPrefsRepository;

  SetIsOpenUseCase(this._sharedPrefsRepository);

  @override
  Future<void> call({bool? params}) async {
    return _sharedPrefsRepository.setIsOpen(params!);
  }
}

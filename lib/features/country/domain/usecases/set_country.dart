import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/country/domain/repository/country_shared_repository.dart';

class SetCountryUseCase implements UseCase<void, String> {
  final CountrySharedRepository _countrySharedRepository;

  SetCountryUseCase(this._countrySharedRepository);

  @override
  Future<void> call({String? params}) async {
    return _countrySharedRepository.setCountry(params!);
  }
}

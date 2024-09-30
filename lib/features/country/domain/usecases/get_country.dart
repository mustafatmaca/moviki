import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/country/domain/repository/country_shared_repository.dart';

class GetCountryUseCase implements UseCase<String?, void> {
  final CountrySharedRepository _countrySharedRepository;

  GetCountryUseCase(this._countrySharedRepository);

  @override
  Future<String?> call({void params}) async {
    return _countrySharedRepository.getCountry();
  }
}

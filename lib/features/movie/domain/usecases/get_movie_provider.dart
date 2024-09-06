import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/movie/domain/entities/movie_provider.dart';
import 'package:moviki/features/movie/domain/repository/movie_provider_repository.dart';

class GetMovieProviderUseCase
    implements UseCase<DataState<List<MovieProviderEntity>>, int> {
  final MovieProviderRepository _movieProviderRepository;

  GetMovieProviderUseCase(this._movieProviderRepository);

  @override
  Future<DataState<List<MovieProviderEntity>>> call({int? params}) {
    return _movieProviderRepository.getMovieProviders(params);
  }
}

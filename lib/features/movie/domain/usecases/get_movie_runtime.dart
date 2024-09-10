import 'package:moviki/core/resources/data_state.dart';
import 'package:moviki/core/usecase/usecase.dart';
import 'package:moviki/features/movie/domain/repository/movie_repository.dart';

class GetMovieRuntimeUseCase implements UseCase<DataState<int?>, int> {
  final MovieRepository _movieRepository;

  GetMovieRuntimeUseCase(this._movieRepository);
  @override
  Future<DataState<int?>> call({int? params}) {
    return _movieRepository.getMovieRuntime(params);
  }
}

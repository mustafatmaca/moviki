import 'package:equatable/equatable.dart';

abstract class AllPopularEvent extends Equatable {
  const AllPopularEvent();

  @override
  List<Object> get props => [];
}

class GetAllPopularMovies extends AllPopularEvent {
  final int? page;
  const GetAllPopularMovies({this.page});
}

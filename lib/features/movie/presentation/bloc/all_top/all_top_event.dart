import 'package:equatable/equatable.dart';

abstract class AllTopEvent extends Equatable {
  const AllTopEvent();

  @override
  List<Object> get props => [];
}

class GetAllTopRatedMovies extends AllTopEvent {
  final int? page;

  const GetAllTopRatedMovies({this.page});

  @override
  List<Object> get props => [page!];
}

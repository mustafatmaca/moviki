import 'package:equatable/equatable.dart';

abstract class IsFavoriteEvent extends Equatable {
  final int? id;

  const IsFavoriteEvent({this.id});

  @override
  List<Object> get props => [id!];
}

class GetFavoriteMovieById extends IsFavoriteEvent {
  const GetFavoriteMovieById(int id) : super(id: id);

  @override
  List<Object> get props => [id!];
}

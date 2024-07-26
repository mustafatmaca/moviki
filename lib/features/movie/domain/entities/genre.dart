import 'package:equatable/equatable.dart';

class GenreEntity extends Equatable {
  final int? id;
  final String? name;

  GenreEntity({this.id, this.name});

  @override
  List<Object?> get props {
    return [id, name];
  }
}

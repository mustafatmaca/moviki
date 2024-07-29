import 'package:equatable/equatable.dart';

class SpokenLanguageEntity extends Equatable {
  final String? englishName;
  final String? iso6391;
  final String? name;

  const SpokenLanguageEntity({this.englishName, this.iso6391, this.name});

  @override
  List<Object?> get props {
    return [englishName, iso6391, name];
  }
}

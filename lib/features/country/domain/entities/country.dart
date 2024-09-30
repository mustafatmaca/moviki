import 'package:equatable/equatable.dart';

class CountryEntity extends Equatable {
  final String? iso31661;
  final String? englishName;
  final String? nativeName;

  const CountryEntity({this.iso31661, this.englishName, this.nativeName});

  @override
  // TODO: implement props
  List<Object?> get props {
    return [
      iso31661,
      englishName,
      nativeName,
    ];
  }
}

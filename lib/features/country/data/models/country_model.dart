import 'dart:convert';

import 'package:moviki/features/country/domain/entities/country.dart';

class CountryModel extends CountryEntity {
  const CountryModel({
    String? iso31661,
    String? englishName,
    String? nativeName,
  }) : super(
          iso31661: iso31661,
          englishName: englishName,
          nativeName: nativeName,
        );

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    return CountryModel(
      iso31661: map['iso_3166_1'] != null ? map['iso_3166_1'] as String : null,
      englishName:
          map['english_name'] != null ? map['english_name'] as String : null,
      nativeName:
          map['native_name'] != null ? map['native_name'] as String : null,
    );
  }

  factory CountryModel.fromJson(String source) =>
      CountryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

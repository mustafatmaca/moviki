import 'dart:convert';

import 'package:moviki/features/movie/domain/entities/movie_provider.dart';

class MovieProviderModel extends MovieProviderEntity {
  const MovieProviderModel({
    String? logoPath,
    int? providerId,
    String? providerName,
    int? displayPriority,
  }) : super(
          logoPath: logoPath,
          providerId: providerId,
          providerName: providerName,
          displayPriority: displayPriority,
        );

  factory MovieProviderModel.fromMap(Map<String, dynamic> map) {
    return MovieProviderModel(
      logoPath: map['logo_path'] != null ? map['logo_path'] as String : null,
      providerId: map['provider_id'] != null ? map['provider_id'] as int : null,
      providerName:
          map['provider_name'] != null ? map['provider_name'] as String : null,
      displayPriority: map['display_priority'] != null
          ? map['display_priority'] as int
          : null,
    );
  }

  factory MovieProviderModel.fromJson(String source) =>
      MovieProviderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory MovieProviderModel.fromEntity(MovieProviderEntity entity) {
    return MovieProviderModel(
      logoPath: entity.logoPath,
      providerId: entity.providerId,
      providerName: entity.providerName,
      displayPriority: entity.displayPriority,
    );
  }
}

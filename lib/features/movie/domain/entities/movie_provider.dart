import 'package:equatable/equatable.dart';

class MovieProviderEntity extends Equatable {
  final String? logoPath;
  final int? providerId;
  final String? providerName;
  final int? displayPriority;

  const MovieProviderEntity(
      {this.logoPath,
      this.providerId,
      this.providerName,
      this.displayPriority});

  @override
  List<Object?> get props {
    return [
      logoPath,
      providerId,
      providerName,
      displayPriority,
    ];
  }
}

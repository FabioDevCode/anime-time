import 'package:anime_time/core/database/database_provider.dart';
import 'package:anime_time/features/profile/data/models/profile_data.dart';
import 'package:anime_time/features/profile/data/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(
    ref.watch(appDatabaseProvider).favoriteAnimeAccessor,
  );
});

/// Flux unique pour le profil, alimenté uniquement par la base Drift locale.
final profileDataProvider = StreamProvider<ProfileData>((ref) {
  return ref.watch(profileRepositoryProvider).watchProfileData();
});

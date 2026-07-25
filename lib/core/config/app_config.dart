/// Lecture des variables d'environnement injectées via --dart-define-from-file.
///
/// Usage:
///   flutter run --dart-define-from-file=config/dev.json --flavor dev
abstract final class AppConfig {
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: '',
  );

  static const String env = String.fromEnvironment('ENV', defaultValue: 'dev');
}

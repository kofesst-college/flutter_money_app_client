abstract class PreferencesRepository {
  Future<String?> restoreSavedApiToken();

  Future<void> saveApiToken(String token);

  Future<void> removeSavedApiToken();
}

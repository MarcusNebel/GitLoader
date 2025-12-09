import 'package:shared_preferences/shared_preferences.dart';

class RepoStorage {
  static const String _key = 'github_repos';

  /// Alle gespeicherten Repos laden
  static Future<List<String>> loadRepos() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  /// Ein neues Repo hinzufügen
  static Future<void> addRepo(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final repos = prefs.getStringList(_key) ?? [];
    if (!repos.contains(url)) {
      repos.add(url);
      await prefs.setStringList(_key, repos);
    }
  }

  /// Ein Repo entfernen
  static Future<void> removeRepo(String url) async {
    final prefs = await SharedPreferences.getInstance();
    final repos = prefs.getStringList(_key) ?? [];
    repos.remove(url);
    await prefs.setStringList(_key, repos);
  }

  /// Alle Repos löschen
  static Future<void> clearRepos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

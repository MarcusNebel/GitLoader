import 'package:gitloader/functions/manage_github_repo_urls.dart';
import 'package:gitloader/functions/update_functions/package_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RepoInstallChecker {
  /// Liefert eine Liste von Maps mit label, package, version und repoUrl
  static Future<List<Map<String, String>>> getInstalledRepos() async {
    // Lade gespeicherte Repo-Infos
    List<Map<String, String>> savedRepos = await _loadInstalledRepos();
    if (savedRepos.isNotEmpty) {
      print("Geladene gespeicherte Repos: $savedRepos");
    }

    final repos = await RepoStorage.loadRepos();
    print("Gefundene Repos in RepoStorage: $repos");

    final installedPackages = await AppChecker.getInstalledPackages();
    print("Installierte Pakete: $installedPackages");

    final installedRepos = <Map<String, String>>[];

    for (var repoUrl in repos) {
      final repoName = _extractRepoName(repoUrl); // Repo-Name extrahieren

      // Suche Package, dessen letztes Segment dem Repo-Namen entspricht
      final matchedPackage = installedPackages.firstWhere(
        (pkg) => pkg.split('.').last.toLowerCase() == repoName,
        orElse: () => "",
      );

      if (matchedPackage.isNotEmpty) {
        String version = await AppChecker.getPackageVersion(matchedPackage) ?? "1.0.0";

        // Prüfe, ob Repo bereits in gespeicherten Daten ist
        final existing = savedRepos.firstWhere(
          (r) => r["package"] == matchedPackage,
          orElse: () => {},
        );

        final repoData = {
          "label": repoName,
          "package": matchedPackage,
          "version": version,
          "repoUrl": existing["repoUrl"] ?? repoUrl, // Falls schon gespeichert, wiederverwenden
        };

        installedRepos.add(repoData);
      }
    }

    // Speichere alle kombinierten Daten in SharedPreferences
    await _saveInstalledRepos(installedRepos);

    return installedRepos;
  }

  static String _extractRepoName(String repoUrl) {
    String name = repoUrl.split('/').last;
    if (name.toLowerCase().endsWith('.git')) {
      name = name.substring(0, name.length - 4);
    }
    name = name.toLowerCase();
    print("Extrahierter Repo-Name: $name");
    return name;
  }

  /// Speichert die Repos persistent
  static Future<void> _saveInstalledRepos(List<Map<String, String>> repos) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = repos.map((r) => jsonEncode(r)).toList();
    await prefs.setStringList('installedRepos', encoded);
    print("Repos in SharedPreferences gespeichert: $encoded");
  }

  /// Lädt gespeicherte Repos
  static Future<List<Map<String, String>>> _loadInstalledRepos() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getStringList('installedRepos') ?? [];
    return encoded.map((s) => Map<String, String>.from(jsonDecode(s))).toList();
  }
}

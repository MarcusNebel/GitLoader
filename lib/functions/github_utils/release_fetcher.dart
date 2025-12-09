// github_release_fetcher.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubRelease {
  final String filename;
  final String version;
  final String releaseName;
  final String description;
  final String downloadUrl;

  GitHubRelease({
    required this.filename,
    required this.version,
    required this.releaseName,
    required this.description,
    required this.downloadUrl,
  });
}

Future<GitHubRelease?> fetchLatestApkRelease(String repoUrl) async {
  try {
    final repoPath = repoUrl
        .replaceFirst(RegExp(r'^(https?:\/\/)?(www\.)?github\.com\/'), '')
        .replaceFirst(RegExp(r'\.git$'), '');

    final apiUrl = 'https://api.github.com/repos/$repoPath/releases';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body) as List<dynamic>;

    for (final release in data) {
      final assets = release['assets'] as List<dynamic>;
      final apkAsset = assets.firstWhere(
        (asset) => (asset['name'] as String).endsWith('.apk'),
        orElse: () => null,
      );

      if (apkAsset != null) {
        return GitHubRelease(
          filename: apkAsset['name'],
          version: release['tag_name'] ?? '',
          releaseName: release['name'] ?? '',
          description: release['body'] ?? '',
          downloadUrl: apkAsset['browser_download_url'] ?? '',
        );
      }
    }

    return null;
  } catch (e) {
    print('Fehler beim Abrufen der Releases: $e');
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:gitloader/gen_l10n/app_localizations.dart';
import 'package:gitloader/functions/github_utils/normalize_github_url.dart';
import 'package:gitloader/functions/manage_github_repo_urls.dart';
import 'package:gitloader/functions/github_utils/release_fetcher.dart';
import 'package:gitloader/functions/apk_utils/apk_downloader.dart';
import 'package:gitloader/functions/apk_utils/apk_installer.dart';

class InstallScreen extends StatefulWidget {
  const InstallScreen({super.key});

  @override
  State<InstallScreen> createState() => _InstallScreenState();
}

class _InstallScreenState extends State<InstallScreen> {
  List<String> repos = [];
  Map<String, GitHubRelease?> releases = {};
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadRepos();
  }

  Future<void> _loadRepos() async {
    final stored = await RepoStorage.loadRepos();
    repos = stored;

    for (final repo in repos) {
      releases[repo] = await fetchLatestApkRelease(repo);
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.install),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                String normalizedUrl = '';
                return StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                    title: const Text('Neues Repo hinzufügen'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                            hintText: 'GitHub Repo URL',
                          ),
                          onChanged: (value) {
                            setState(() {
                              normalizedUrl = normalizeGitHubUrl(value);
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          normalizedUrl,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Abbrechen'),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (normalizedUrl.isNotEmpty) {
                            await RepoStorage.addRepo(normalizedUrl);
                            Navigator.of(context).pop();
                            _loadRepos();
                          }
                        },
                        child: const Text('Hinzufügen'),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: repos.length,
              itemBuilder: (context, index) {
                final repo = repos[index];
                final release = releases[repo];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(repo,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        if (release == null)
                          const Text('Keine APK-Releases gefunden')
                        else ...[
                          Text('Version: ${release.version}'),
                          Text('Release: ${release.releaseName}'),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () async {
                              if (release == null) return;

                              // Nutzer informieren, dass Download gestartet wird
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Download wird gestartet...")),
                              );

                              // APK herunterladen
                              final path = await ApkDownloader.downloadApk(
                                release.downloadUrl,
                                release.filename,
                              );

                              if (path == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Download fehlgeschlagen")),
                                );
                                return;
                              }

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("APK gespeichert unter: $path")),
                              );

                              // APK installieren
                              final installer = ApkInstaller();
                              final ok = await installer.installApk(path);

                              if (!ok) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Installation fehlgeschlagen")),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Installation gestartet")),
                                );
                              }
                            },
                            child: const Text("Installieren"),
                          )
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

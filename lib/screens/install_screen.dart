import 'package:flutter/material.dart';
import 'package:gitloader/gen_l10n/app_localizations.dart';
import 'package:gitloader/functions/github_utils/normalize_github_url.dart';
import 'package:gitloader/functions/manage_github_repo_urls.dart';
import 'package:gitloader/functions/github_utils/release_fetcher.dart';
import 'package:gitloader/functions/apk_utils/apk_downloader.dart';
import 'package:gitloader/functions/apk_utils/apk_installer.dart';
import 'package:gitloader/functions/update_functions/package_checker.dart';

class InstallScreen extends StatefulWidget {
  const InstallScreen({super.key});

  @override
  State<InstallScreen> createState() => _InstallScreenState();
}

class _InstallScreenState extends State<InstallScreen> {
  List<String> repos = [];
  Map<String, GitHubRelease?> releases = {};
  List<Map<String, String>> installedApps = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadRepos();
  }

  Future<void> _loadRepos() async {
    if (!mounted) return;
    setState(() => loading = true);

    final storedRepos = await RepoStorage.loadRepos();
    repos = storedRepos;

    final installedPackages = await AppChecker.getInstalledPackages();

    installedApps = [];
    for (final repoUrl in repos) {
      final repoName = repoUrl.split('/').last.toLowerCase().replaceAll('.git', '');
      final matchedPackage = installedPackages.firstWhere(
        (pkg) => pkg.split('.').last.toLowerCase() == repoName,
        orElse: () => "",
      );

      installedApps.add({
        "label": repoName,
        "repoUrl": repoUrl,
        "package": matchedPackage,
      });
    }

    for (final repo in repos) {
      final release = await fetchLatestApkRelease(repo);
      releases[repo] = release;
    }

    if (!mounted) return;
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.install),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  String normalizedUrl = '';
                  return StatefulBuilder(
                    builder: (context, setState) => AlertDialog(
                      title: Text(loc.install_add_repo),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: loc.install_add_repo_hint,
                            ),
                            onChanged: (value) {
                              if (!mounted) return;
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
                          child: Text(loc.install_add_repo_cancel),
                        ),
                        TextButton(
                          onPressed: () async {
                            if (normalizedUrl.isNotEmpty) {
                              await RepoStorage.addRepo(normalizedUrl);
                              Navigator.of(context).pop();
                              _loadRepos();
                            }
                          },
                          child: Text(loc.install_add_repo_add),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: installedApps.length,
              itemBuilder: (context, index) {
                final app = installedApps[index];
                final release = releases[app["repoUrl"] ?? ""];

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
                        Text(
                          app["label"] ?? "Unbekannt",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        if (release != null) ...[
                          Text(
                            loc.settings_repository_options_version(release.version),
                          ),
                          Text(loc.settings_repository_options_filename(release.filename)),
                          const SizedBox(height: 8),
                          if (app["package"] != null && app["package"]!.isNotEmpty)
                            Text(
                              loc.install_already_installed,
                              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                            )
                          else
                            ElevatedButton(
                              onPressed: () async {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(loc.install_download_start)),
                                );

                                final path = await ApkDownloader.downloadApk(
                                  release.downloadUrl,
                                  release.filename,
                                );

                                if (path == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(loc.install_download_failed)),
                                  );
                                  return;
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(loc.install_download_saved(path))),
                                );

                                final installer = ApkInstaller();
                                final ok = await installer.installApk(path);

                                if (!ok) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(loc.install_installation_failed)),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(loc.install_installation_started)),
                                  );
                                }
                              },
                              child: Text(loc.install_install),
                            ),
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

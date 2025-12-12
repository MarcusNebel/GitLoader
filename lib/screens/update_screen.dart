import 'package:flutter/material.dart';
import 'package:gitloader/gen_l10n/app_localizations.dart';
import 'package:gitloader/functions/update_functions/app_checker.dart';
import 'package:gitloader/functions/github_utils/release_fetcher.dart';
import 'package:gitloader/functions/apk_utils/apk_downloader.dart';
import 'package:gitloader/functions/apk_utils/apk_installer.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List<Map<String, String>> installedApps = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadInstalledApps();
  }

  Future<void> _loadInstalledApps() async {
    setState(() => loading = true);

    bool isVersionNewer(String latest, String current) {
      String clean(String v) => v.startsWith('v') ? v.substring(1) : v;
      final latestParts = clean(latest).split('.').map(int.parse).toList();
      final currentParts = clean(current).split('.').map(int.parse).toList();
      final length = latestParts.length > currentParts.length
          ? latestParts.length
          : currentParts.length;

      for (int i = 0; i < length; i++) {
        final l = i < latestParts.length ? latestParts[i] : 0;
        final c = i < currentParts.length ? currentParts[i] : 0;
        if (l > c) return true;
        if (l < c) return false;
      }
      return false;
    }

    final apps = await RepoInstallChecker.getInstalledRepos();

    final appsWithStatus = await Future.wait(apps.map((app) async {
      final label = app["label"] ?? "Unbekannt";
      final package = app["package"] ?? "-";
      final currentVersion = app["version"] ?? "1.0.0";

      String updateStatus = AppLocalizations.of(context)!.update_no_updates;

      if (app["repoUrl"] != null && app["repoUrl"]!.isNotEmpty) {
        final latestRelease = await fetchLatestApkRelease(app["repoUrl"]!);
        if (latestRelease != null) {
          if (isVersionNewer(latestRelease.version, currentVersion)) {
            updateStatus = AppLocalizations.of(context)!
                .update_available(latestRelease.version);
          }
        }
      }

      return {
        "label": label,
        "package": package,
        "version": currentVersion,
        "updateStatus": updateStatus,
        "repoUrl": app["repoUrl"] ?? "",
      };
    }));

    setState(() {
      installedApps = appsWithStatus;
      loading = false;
    });
  }

  Future<void> _updateInstalledApp(
      Map<String, String> app, GitHubRelease release) async {
    final label = app["label"] ?? "Unbekannt";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!
            .update_download_start(label)),
      ),
    );

    final path = await ApkDownloader.downloadApk(
      release.downloadUrl,
      release.filename,
    );

    if (path == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!
              .update_download_failed(label)),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!
            .update_download_saved(path)),
      ),
    );

    final installer = ApkInstaller();
    final ok = await installer.installApk(path);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(ok
            ? AppLocalizations.of(context)!.update_installation_started(label)
            : AppLocalizations.of(context)!.update_installation_failed(label)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.update),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadInstalledApps,
            tooltip: loc.update_refresh,
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : installedApps.isEmpty
              ? Center(child: Text(loc.update_no_repos))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: installedApps.length,
                  itemBuilder: (context, index) {
                    final app = installedApps[index];
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  app["label"] ?? "Unbekannt",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "v${app["version"] ?? "-"}",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              loc.update_package(app["package"] ?? "-"),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () async {
                                if (app["repoUrl"] == null ||
                                    app["repoUrl"]!.isEmpty) return;
                                final release = await fetchLatestApkRelease(
                                    app["repoUrl"]!);
                                if (release != null) {
                                  await _updateInstalledApp(app, release);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(loc.update_no_apk_found(
                                          app["label"] ?? "Unbekannt")),
                                    ),
                                  );
                                }
                              },
                              child: Text(loc.update_button),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              app["updateStatus"] ?? "",
                              style: TextStyle(
                                fontSize: 14,
                                color: app["updateStatus"]!
                                        .startsWith(loc.update_available(''))
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

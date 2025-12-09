import 'package:flutter/material.dart';
import 'package:gitloader/functions/manage_github_repo_urls.dart';
import 'package:gitloader/functions/github_utils/release_fetcher.dart';
import 'package:gitloader/gen_l10n/app_localizations.dart';

class ReposScreen extends StatefulWidget {
  const ReposScreen({super.key});

  @override
  State<ReposScreen> createState() => _ReposScreenState();
}

class _ReposScreenState extends State<ReposScreen> {
  List<String> repos = [];

  @override
  void initState() {
    super.initState();
    _loadRepos();
  }

  Future<void> _loadRepos() async {
    final loadedRepos = await RepoStorage.loadRepos();
    setState(() {
      repos = loadedRepos;
    });
  }

  Future<void> _showReleaseData(String repo) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final release = await fetchLatestApkRelease(repo);

    Navigator.of(context).pop();

    if (release == null) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.settings_repository_options_no_apks_found),
          content: Text(AppLocalizations.of(context)!.settings_repository_options_no_apks_found_description),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(release.releaseName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.settings_repository_options_version(release.version)),
            Text(AppLocalizations.of(context)!.settings_repository_options_filename(release.filename)),
            const SizedBox(height: 10),
            Text(AppLocalizations.of(context)!.settings_repository_options_description),
            Text(release.description),
            const SizedBox(height: 10),
            Text(AppLocalizations.of(context)!.settings_repository_options_download_url),
            SelectableText(release.downloadUrl),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context)!.finish),
          ),
        ],
      ),
    );
  }

  Widget _buildRepoCard(String repo) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        leading: Icon(Icons.storage, color: Theme.of(context).colorScheme.primary),
        title: Text(repo),
        subtitle: Text(AppLocalizations.of(context)!.settings_repository_options_tap_to_view_release),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () async {
            await RepoStorage.removeRepo(repo);
            _loadRepos();
          },
        ),
        onTap: () => _showReleaseData(repo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings_repositories),
        centerTitle: true,
      ),
      body: repos.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.settings_repository_options_no_repositories))
          : ListView.builder(
              itemCount: repos.length,
              itemBuilder: (context, index) {
                final repo = repos[index];
                return _buildRepoCard(repo);
              },
            ),
    );
  }
}

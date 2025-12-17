import 'package:flutter/material.dart';
import 'package:gitloader/functions/manage_github_repo_urls.dart';
import 'package:gitloader/functions/github_utils/release_fetcher.dart';
import 'package:gitloader/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReposScreen extends StatefulWidget {
  const ReposScreen({super.key});

  @override
  State<ReposScreen> createState() => _ReposScreenState();
}

class _ReposScreenState extends State<ReposScreen> {
  List<String> repos = [];
  TextEditingController tokenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRepos();
    _loadToken();
  }

  Future<void> _loadRepos() async {
    final loadedRepos = await RepoStorage.loadRepos();
    if (!mounted) return;
    setState(() {
      repos = loadedRepos;
    });
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    tokenController.text = prefs.getString('github_token') ?? '';
  }

  Future<void> _saveToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('github_token', tokenController.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.settings_repository_options_token_saved)),
    );
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
    final loc = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Fokus vom Textfeld entfernen
      child: Scaffold(
        appBar: AppBar(
          title: Text(loc.settings_github),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            // === GitHub API Token Bereich ===
            Text(
              loc.settings_repository_options_github_token,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextFormField(
                controller: tokenController,
                decoration: InputDecoration(
                  hintText: loc.settings_repository_options_github_token_hint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveToken,
                child: Text(loc.settings_repository_options_save_token),
              ),
            ),
            const SizedBox(height: 20),
            // === Repository Bereich ===
            Text(
              loc.settings_repository_options_repositories,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            repos.isEmpty
                ? Center(child: Text(loc.settings_repository_options_no_repositories))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: repos.length,
                    itemBuilder: (context, index) {
                      final repo = repos[index];
                      return _buildRepoCard(repo);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

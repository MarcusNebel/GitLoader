import 'package:flutter/material.dart';
import 'package:gitloader/gen_l10n/app_localizations.dart';
import 'package:gitloader/functions/github_utils/normalize_github_url.dart';
import 'package:gitloader/functions/manage_github_repo_urls.dart';
import 'package:gitloader/functions/github_utils/release_fetcher.dart';

class InstallScreen extends StatefulWidget {
  const InstallScreen({super.key});

  @override
  State<InstallScreen> createState() => _InstallScreenState();
}

class _InstallScreenState extends State<InstallScreen> {
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
    );
  }
}

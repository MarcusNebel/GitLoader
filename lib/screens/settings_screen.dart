import 'package:flutter/material.dart';
import 'package:gitloader/gen_l10n/app_localizations.dart';
import 'package:gitloader/screens/settings_screens/repo_screen.dart';
import 'package:gitloader/screens/theme_screens/theme_screen.dart';
import 'package:gitloader/screens/language_screens/language_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildCard(
            context,
            title: AppLocalizations.of(context)!.settings_repositories,
            subtitle: AppLocalizations.of(context)!.settings_repository_options_manage_your_repositories,
            icon: Icons.storage,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReposScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildCard(
            context,
            title: AppLocalizations.of(context)!.settings_language,
            subtitle: AppLocalizations.of(context)!.settings_language_manage_languages,
            icon: Icons.language,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LanguagesScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildCard(
            context,
            title: AppLocalizations.of(context)!.settings_theme,
            subtitle: AppLocalizations.of(context)!.settings_theme_manage_themes,
            icon: Icons.palette,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ThemesScreen()),
              );
            },
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title,
      required String subtitle,
      required IconData icon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 48, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}

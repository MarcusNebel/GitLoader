import 'package:flutter/material.dart';
import 'package:gitloader/gen_l10n/app_localizations.dart';
import 'package:gitloader/screens/settings_screens/repo_screen.dart';
import 'package:gitloader/screens/theme_screens/theme_screen.dart';
import 'package:gitloader/screens/language_screens/language_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            title: AppLocalizations.of(context)!.settings_github,
            subtitle: AppLocalizations.of(context)!.settings_repository_options_manage_your_github_settings,
            iconWidget: SvgPicture.asset(
              'lib/assets/icons/github-icon.svg',
              width: 36,
              height: 36,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
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
            iconData: Icons.language,
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
            iconData: Icons.palette,
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

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    IconData? iconData,
    Widget? iconWidget,
    required VoidCallback onTap,
  }) {
    assert(iconData != null || iconWidget != null,
        'Entweder iconData oder iconWidget muss gesetzt sein');

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              iconWidget ??
                  Icon(
                    iconData,
                    size: 36,
                    color: Theme.of(context).colorScheme.primary,
                  ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
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

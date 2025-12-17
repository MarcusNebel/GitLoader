import 'package:flutter/material.dart';
import 'package:gitloader/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

class ThemesScreen extends StatefulWidget {
  const ThemesScreen({super.key});

  @override
  State<ThemesScreen> createState() => _ThemesScreenState();
}

class _ThemesScreenState extends State<ThemesScreen> {
  ThemeMode _selectedMode = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('theme');

    if (!mounted) return;
    setState(() {
      if (saved == 'light') {
        _selectedMode = ThemeMode.light;
      } else if (saved == 'dark') {
        _selectedMode = ThemeMode.dark;
      } else {
        _selectedMode = ThemeMode.system;
      }
    });
  }

  Future<void> _setTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    if (mode == ThemeMode.light) {
      await prefs.setString('theme', 'light');
    } else if (mode == ThemeMode.dark) {
      await prefs.setString('theme', 'dark');
    } else {
      await prefs.setString('theme', 'system');
    }

    MyApp.of(context)?.setThemeMode(mode);

    if (!mounted) return;
    setState(() {
      _selectedMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildThemeCard(
            title: AppLocalizations.of(context)!.settings_theme_options_system,
            mode: ThemeMode.system,
          ),
          const SizedBox(height: 12),
          _buildThemeCard(
            title: AppLocalizations.of(context)!.settings_theme_options_light,
            mode: ThemeMode.light,
          ),
          const SizedBox(height: 12),
          _buildThemeCard(
            title: AppLocalizations.of(context)!.settings_theme_options_dark,
            mode: ThemeMode.dark,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCard({
    required String title,
    required ThemeMode mode,
  }) {
    final bool isSelected = _selectedMode == mode;

    return GestureDetector(
      onTap: () => _setTheme(mode),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),

              // Radio-Knopf ohne Material-Overlay
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Colors.grey,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

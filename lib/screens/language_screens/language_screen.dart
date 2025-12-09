import 'package:flutter/material.dart';
import 'package:gitloader/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  Locale? _selectedLocale;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('language');
    setState(() {
      _selectedLocale = code == null || code == 'system' ? null : Locale(code);
    });
  }

  Future<void> _setLanguage(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.setString('language', 'system');
    } else {
      await prefs.setString('language', locale.languageCode);
    }

    MyApp.of(context)?.setLocale(locale);

    setState(() {
      _selectedLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final supportedLocales = AppLocalizations.supportedLocales;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings_language),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          _buildLanguageCard(
            title: AppLocalizations.of(context)!.settings_language_options_system,
            locale: null,
          ),
          const SizedBox(height: 12),

          // Unterstützte Sprachen
          ...supportedLocales.map((locale) {
            final displayName = locale.languageCode == 'en'
                ? AppLocalizations.of(context)!.settings_language_options_english
                : locale.languageCode == 'de'
                    ? AppLocalizations.of(context)!.settings_language_options_german
                    : locale.languageCode;

            return Column(
              children: [
                _buildLanguageCard(
                  title: displayName,
                  locale: locale,
                ),
                const SizedBox(height: 12),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildLanguageCard({
    required String title,
    required Locale? locale,
  }) {
    final bool isSelected = _selectedLocale?.languageCode == locale?.languageCode;

    return GestureDetector(
      onTap: () => _setLanguage(locale),
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

              // Radio-Look ohne echte RadioListTile (keine Effekte)
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

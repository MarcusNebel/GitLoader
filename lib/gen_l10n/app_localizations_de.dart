// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get home => 'Startseite';

  @override
  String get settings => 'Einstellungen';

  @override
  String get install => 'Installieren';

  @override
  String get update => 'Aktualisieren';

  @override
  String get finish => 'Fertig';

  @override
  String get settings_language => 'Sprache';

  @override
  String get settings_theme => 'Thema';

  @override
  String get settings_repositories => 'Repositorys verwalten';

  @override
  String get settings_repository_options_manage_your_repositories =>
      'Verwalte deine Repositorys';

  @override
  String get settings_repository_options_no_repositories =>
      'Keine Repositorys hinzugefügt.';

  @override
  String get settings_repository_options_tap_to_view_release =>
      'Tippen zum Anzeigen der Releases';

  @override
  String get settings_repository_options_no_apks_found =>
      'Keine APKs gefunden.';

  @override
  String get settings_repository_options_no_apks_found_description =>
      'Dieses Repo enthält kein Release mit einer APK-Datei.';

  @override
  String settings_repository_options_version(Object version) {
    return 'Version: $version';
  }

  @override
  String settings_repository_options_filename(Object filename) {
    return 'Dateiname: $filename';
  }

  @override
  String get settings_repository_options_description => 'Beschreibung:';

  @override
  String get settings_repository_options_download_url => 'Download-URL:';

  @override
  String get settings_language_manage_languages => 'Sprachen verwalten';

  @override
  String get settings_language_options_system => 'Systemstandard';

  @override
  String get settings_language_options_english => 'Englisch';

  @override
  String get settings_language_options_german => 'Deutsch';

  @override
  String get settings_theme_manage_themes => 'Themen verwalten';

  @override
  String get settings_theme_options_system => 'Systemstandard';

  @override
  String get settings_theme_options_light => 'Hell';

  @override
  String get settings_theme_options_dark => 'Dunkel';
}

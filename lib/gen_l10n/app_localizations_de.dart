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

  @override
  String get install_install => 'Installieren';

  @override
  String get install_add_repo => 'Neues Repo hinzufügen';

  @override
  String get install_add_repo_hint => 'GitHub Repo URL';

  @override
  String get install_add_repo_cancel => 'Abbrechen';

  @override
  String get install_add_repo_add => 'Hinzufügen';

  @override
  String get install_already_installed => 'App ist bereits installiert';

  @override
  String get install_download_start => 'Download wird gestartet...';

  @override
  String get install_download_failed => 'Download fehlgeschlagen';

  @override
  String install_download_saved(Object path) {
    return 'APK gespeichert unter: $path';
  }

  @override
  String get install_installation_failed => 'Installation fehlgeschlagen';

  @override
  String get install_installation_started => 'Installation gestartet';

  @override
  String get update_refresh => 'Aktualisieren';

  @override
  String get update_no_repos => 'Keine installierten Repos gefunden';

  @override
  String update_package(Object package) {
    return 'Package: $package';
  }

  @override
  String get update_button => 'Update installieren';

  @override
  String update_download_start(Object label) {
    return 'Download für $label wird gestartet...';
  }

  @override
  String update_download_failed(Object label) {
    return 'Download für $label fehlgeschlagen';
  }

  @override
  String update_download_saved(Object path) {
    return 'APK gespeichert unter: $path';
  }

  @override
  String update_installation_failed(Object label) {
    return 'Installation für $label fehlgeschlagen';
  }

  @override
  String update_installation_started(Object label) {
    return 'Installation für $label gestartet';
  }

  @override
  String update_no_apk_found(Object label) {
    return 'Keine APK-Releases gefunden für $label';
  }

  @override
  String get update_no_updates => 'Keine Updates gefunden';

  @override
  String update_available(Object version) {
    return 'Update verfügbar: $version';
  }
}

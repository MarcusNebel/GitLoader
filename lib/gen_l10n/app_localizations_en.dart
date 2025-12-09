// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get install => 'Install';

  @override
  String get update => 'Update';

  @override
  String get finish => 'Finish';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_theme => 'Theme';

  @override
  String get settings_repositories => 'Manage Repositories';

  @override
  String get settings_repository_options_manage_your_repositories =>
      'Manage your repositories';

  @override
  String get settings_repository_options_no_repositories =>
      'No repositories added.';

  @override
  String get settings_repository_options_tap_to_view_release =>
      'Tap to view releases';

  @override
  String get settings_repository_options_no_apks_found => 'No APKs found.';

  @override
  String get settings_repository_options_no_apks_found_description =>
      'This repo does not contain a release with an APK file.';

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
  String get settings_language_manage_languages => 'Manage languages';

  @override
  String get settings_language_options_system => 'System Default';

  @override
  String get settings_language_options_english => 'English';

  @override
  String get settings_language_options_german => 'German';

  @override
  String get settings_theme_manage_themes => 'Manage themes';

  @override
  String get settings_theme_options_system => 'System Default';

  @override
  String get settings_theme_options_light => 'Light';

  @override
  String get settings_theme_options_dark => 'Dark';
}

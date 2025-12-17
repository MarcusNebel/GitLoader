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
  String get settings_github => 'Github Settings';

  @override
  String get settings_repository_options_manage_your_github_settings =>
      'Manage your GitHub settings';

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
    return 'Filename: $filename';
  }

  @override
  String get settings_repository_options_description => 'Description:';

  @override
  String get settings_repository_options_download_url => 'Download-URL:';

  @override
  String get settings_repository_options_github_token => 'GitHub API Token';

  @override
  String get settings_repository_options_github_token_hint =>
      'Enter your GitHub API token';

  @override
  String get settings_repository_options_save_token => 'Save token';

  @override
  String get settings_repository_options_token_saved =>
      'GitHub token saved successfully';

  @override
  String get settings_repository_options_repositories => 'Repositories';

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

  @override
  String get install_install => 'Install';

  @override
  String get install_add_repo => 'Add new repo';

  @override
  String get install_add_repo_hint => 'GitHub Repo URL';

  @override
  String get install_add_repo_cancel => 'Cancel';

  @override
  String get install_add_repo_add => 'Add';

  @override
  String get install_already_installed => 'App is already installed';

  @override
  String get install_download_start => 'Download starting...';

  @override
  String get install_download_failed => 'Download failed';

  @override
  String install_download_saved(Object path) {
    return 'APK saved at: $path';
  }

  @override
  String get install_installation_failed => 'Installation failed';

  @override
  String get install_installation_started => 'Installation started';

  @override
  String get update_refresh => 'Refresh';

  @override
  String get update_no_repos => 'No installed repos found';

  @override
  String update_package(Object package) {
    return 'Package: $package';
  }

  @override
  String get update_button => 'Install update';

  @override
  String update_download_start(Object label) {
    return 'Download for $label starting...';
  }

  @override
  String update_download_failed(Object label) {
    return 'Download for $label failed';
  }

  @override
  String update_download_saved(Object path) {
    return 'APK saved at: $path';
  }

  @override
  String update_installation_failed(Object label) {
    return 'Installation for $label failed';
  }

  @override
  String update_installation_started(Object label) {
    return 'Installation for $label started';
  }

  @override
  String update_no_apk_found(Object label) {
    return 'No APK releases found for $label';
  }

  @override
  String get update_no_updates => 'No updates found';

  @override
  String update_available(Object version) {
    return 'Update available: $version';
  }
}

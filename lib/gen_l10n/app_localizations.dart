import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @install.
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get install;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme;

  /// No description provided for @settings_github.
  ///
  /// In en, this message translates to:
  /// **'Github Settings'**
  String get settings_github;

  /// No description provided for @settings_repository_options_manage_your_github_settings.
  ///
  /// In en, this message translates to:
  /// **'Manage your GitHub settings'**
  String get settings_repository_options_manage_your_github_settings;

  /// No description provided for @settings_repository_options_no_repositories.
  ///
  /// In en, this message translates to:
  /// **'No repositories added.'**
  String get settings_repository_options_no_repositories;

  /// No description provided for @settings_repository_options_tap_to_view_release.
  ///
  /// In en, this message translates to:
  /// **'Tap to view releases'**
  String get settings_repository_options_tap_to_view_release;

  /// No description provided for @settings_repository_options_no_apks_found.
  ///
  /// In en, this message translates to:
  /// **'No APKs found.'**
  String get settings_repository_options_no_apks_found;

  /// No description provided for @settings_repository_options_no_apks_found_description.
  ///
  /// In en, this message translates to:
  /// **'This repo does not contain a release with an APK file.'**
  String get settings_repository_options_no_apks_found_description;

  /// No description provided for @settings_repository_options_version.
  ///
  /// In en, this message translates to:
  /// **'Version: {version}'**
  String settings_repository_options_version(Object version);

  /// No description provided for @settings_repository_options_filename.
  ///
  /// In en, this message translates to:
  /// **'Filename: {filename}'**
  String settings_repository_options_filename(Object filename);

  /// No description provided for @settings_repository_options_description.
  ///
  /// In en, this message translates to:
  /// **'Description:'**
  String get settings_repository_options_description;

  /// No description provided for @settings_repository_options_download_url.
  ///
  /// In en, this message translates to:
  /// **'Download-URL:'**
  String get settings_repository_options_download_url;

  /// No description provided for @settings_repository_options_github_token.
  ///
  /// In en, this message translates to:
  /// **'GitHub API Token'**
  String get settings_repository_options_github_token;

  /// No description provided for @settings_repository_options_github_token_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your GitHub API token'**
  String get settings_repository_options_github_token_hint;

  /// No description provided for @settings_repository_options_save_token.
  ///
  /// In en, this message translates to:
  /// **'Save token'**
  String get settings_repository_options_save_token;

  /// No description provided for @settings_repository_options_token_saved.
  ///
  /// In en, this message translates to:
  /// **'GitHub token saved successfully'**
  String get settings_repository_options_token_saved;

  /// No description provided for @settings_repository_options_repositories.
  ///
  /// In en, this message translates to:
  /// **'Repositories'**
  String get settings_repository_options_repositories;

  /// No description provided for @settings_language_manage_languages.
  ///
  /// In en, this message translates to:
  /// **'Manage languages'**
  String get settings_language_manage_languages;

  /// No description provided for @settings_language_options_system.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get settings_language_options_system;

  /// No description provided for @settings_language_options_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settings_language_options_english;

  /// No description provided for @settings_language_options_german.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get settings_language_options_german;

  /// No description provided for @settings_theme_manage_themes.
  ///
  /// In en, this message translates to:
  /// **'Manage themes'**
  String get settings_theme_manage_themes;

  /// No description provided for @settings_theme_options_system.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get settings_theme_options_system;

  /// No description provided for @settings_theme_options_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_theme_options_light;

  /// No description provided for @settings_theme_options_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_theme_options_dark;

  /// No description provided for @install_install.
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get install_install;

  /// No description provided for @install_add_repo.
  ///
  /// In en, this message translates to:
  /// **'Add new repo'**
  String get install_add_repo;

  /// No description provided for @install_add_repo_hint.
  ///
  /// In en, this message translates to:
  /// **'GitHub Repo URL'**
  String get install_add_repo_hint;

  /// No description provided for @install_add_repo_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get install_add_repo_cancel;

  /// No description provided for @install_add_repo_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get install_add_repo_add;

  /// No description provided for @install_already_installed.
  ///
  /// In en, this message translates to:
  /// **'App is already installed'**
  String get install_already_installed;

  /// No description provided for @install_download_start.
  ///
  /// In en, this message translates to:
  /// **'Download starting...'**
  String get install_download_start;

  /// No description provided for @install_download_failed.
  ///
  /// In en, this message translates to:
  /// **'Download failed'**
  String get install_download_failed;

  /// No description provided for @install_download_saved.
  ///
  /// In en, this message translates to:
  /// **'APK saved at: {path}'**
  String install_download_saved(Object path);

  /// No description provided for @install_installation_failed.
  ///
  /// In en, this message translates to:
  /// **'Installation failed'**
  String get install_installation_failed;

  /// No description provided for @install_installation_started.
  ///
  /// In en, this message translates to:
  /// **'Installation started'**
  String get install_installation_started;

  /// No description provided for @update_refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get update_refresh;

  /// No description provided for @update_no_repos.
  ///
  /// In en, this message translates to:
  /// **'No installed repos found'**
  String get update_no_repos;

  /// No description provided for @update_package.
  ///
  /// In en, this message translates to:
  /// **'Package: {package}'**
  String update_package(Object package);

  /// No description provided for @update_button.
  ///
  /// In en, this message translates to:
  /// **'Install update'**
  String get update_button;

  /// No description provided for @update_download_start.
  ///
  /// In en, this message translates to:
  /// **'Download for {label} starting...'**
  String update_download_start(Object label);

  /// No description provided for @update_download_failed.
  ///
  /// In en, this message translates to:
  /// **'Download for {label} failed'**
  String update_download_failed(Object label);

  /// No description provided for @update_download_saved.
  ///
  /// In en, this message translates to:
  /// **'APK saved at: {path}'**
  String update_download_saved(Object path);

  /// No description provided for @update_installation_failed.
  ///
  /// In en, this message translates to:
  /// **'Installation for {label} failed'**
  String update_installation_failed(Object label);

  /// No description provided for @update_installation_started.
  ///
  /// In en, this message translates to:
  /// **'Installation for {label} started'**
  String update_installation_started(Object label);

  /// No description provided for @update_no_apk_found.
  ///
  /// In en, this message translates to:
  /// **'No APK releases found for {label}'**
  String update_no_apk_found(Object label);

  /// No description provided for @update_no_updates.
  ///
  /// In en, this message translates to:
  /// **'No updates found'**
  String get update_no_updates;

  /// No description provided for @update_available.
  ///
  /// In en, this message translates to:
  /// **'Update available: {version}'**
  String update_available(Object version);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

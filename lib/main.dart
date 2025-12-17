import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gitloader/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'screens/install_screen.dart';
import 'screens/update_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // Sprache laden
  final savedLanguage = prefs.getString('language');
  final initialLocale =
      (savedLanguage == null || savedLanguage == 'system') ? null : Locale(savedLanguage);

  // Theme laden
  final savedTheme = prefs.getString('theme');
  ThemeMode initialThemeMode;
  if (savedTheme == 'light') {
    initialThemeMode = ThemeMode.light;
  } else if (savedTheme == 'dark') {
    initialThemeMode = ThemeMode.dark;
  } else {
    initialThemeMode = ThemeMode.system;
  }

  runApp(MyApp(
    initialLocale: initialLocale,
    initialThemeMode: initialThemeMode,
  ));
}

class MyApp extends StatefulWidget {
  final Locale? initialLocale;
  final ThemeMode initialThemeMode;

  const MyApp({
    super.key,
    this.initialLocale,
    required this.initialThemeMode,
  });

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
    _themeMode = widget.initialThemeMode;
  }

  void setLocale(Locale? locale) {
    if (!mounted) return;
    setState(() {
      _locale = locale;
    });
  }

  void setThemeMode(ThemeMode mode) {
    if (!mounted) return;
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      locale: _locale,
      themeMode: _themeMode,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: AppLocalizations.supportedLocales,

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),

      home: const ThemeTestPage(),
    );
  }
}

class ThemeTestPage extends StatefulWidget {
  const ThemeTestPage({super.key});

  @override
  State<ThemeTestPage> createState() => _ThemeTestPageState();
}

class _ThemeTestPageState extends State<ThemeTestPage> {
  int currentPageIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const InstallScreen(),
    const UpdateScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.home,
          ),
          NavigationDestination(
            icon: const Icon(Icons.download),
            label: AppLocalizations.of(context)!.install,
          ),
          NavigationDestination(
            icon: const Icon(Icons.refresh_rounded),
            label: AppLocalizations.of(context)!.update,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_rounded),
            label: AppLocalizations.of(context)!.settings,
          ),
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) {
          if (!mounted) return;
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
      body: screens[currentPageIndex],
    );
  }
}

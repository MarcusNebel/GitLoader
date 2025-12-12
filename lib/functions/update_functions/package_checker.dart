import 'package:flutter/services.dart';

class AppChecker {
  static const platform = MethodChannel("app.installer/check");

  /// Prüft, ob ein sichtbarer Name installiert ist
  static Future<bool> isInstalledByLabel(String label) async {
    return await platform.invokeMethod("isAppInstalledByLabel", {
      "label": label,
    });
  }

  /// Alle installierten Package-Namen abrufen
  static Future<List<String>> getInstalledPackages() async {
    final List<dynamic> packages =
        await platform.invokeMethod("getInstalledPackages");
    return packages.map((e) => e.toString()).toList();
  }

  static Future<String?> getPackageVersion(String packageName) async {
    return await platform.invokeMethod("getPackageVersion", {"package": packageName});
  }
}

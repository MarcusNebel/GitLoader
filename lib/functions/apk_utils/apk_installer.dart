import 'dart:io';
import 'package:flutter_app_installer/flutter_app_installer.dart';

class ApkInstaller {
  /// Installiert eine APK über den Android-Systeminstaller.
  Future<bool> installApk(String filePath) async {
    try {
      final file = File(filePath);
      if (!file.existsSync()) {
        print("APK-Datei existiert nicht: $filePath");
        return false;
      }

      print("Installations-Intent gestartet für ${file.path}");
      final installer = FlutterAppInstaller();
      await installer.installApk(filePath: file.path);
      return true;
    } catch (e) {
      print("Fehler bei Installation: $e");
      return false;
    }
  }
}

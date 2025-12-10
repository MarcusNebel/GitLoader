import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ApkDownloader {
  /// Lädt eine APK herunter und gibt den lokalen Datei-Pfad zurück.
  /// Druckt den Fortschritt in die Konsole.
  static Future<String?> downloadApk(String url, String fileName) async {
    try {
      final uri = Uri.parse(url);
      final request = http.Request('GET', uri);
      final response = await request.send();

      if (response.statusCode != 200) {
        print("Download fehlgeschlagen: HTTP ${response.statusCode}");
        return null;
      }

      final contentLength = response.contentLength ?? 0;
      int received = 0;

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$fileName');
      final sink = file.openWrite();

      await for (var chunk in response.stream) {
        received += chunk.length;
        sink.add(chunk);

        if (contentLength != 0) {
          final progress = (received / contentLength * 100).toStringAsFixed(1);
          print("Download Fortschritt: $progress%");
        }
      }

      await sink.close();

      print("Download abgeschlossen: ${file.path}");
      return file.path;
    } catch (e) {
      print("Fehler beim Download: $e");
      return null;
    }
  }
}

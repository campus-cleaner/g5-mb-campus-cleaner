import 'dart:io';
import 'package:g5_mb_campus_cleaner/services/file_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtil {
  static Future<File> getFileFromAsset(
      String assetPath, String fileName) async {
    ByteData byteData = await rootBundle.load(assetPath);
    Uint8List bytes = byteData.buffer.asUint8List();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  static Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }

  static Future<File> getFileFromServer(String filename) async {
    String url = FileService.getUrlImageFromServer(filename);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/${filename.replaceAll('/', '-')}');
      file.writeAsBytesSync(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to load image');
    }
  }
}

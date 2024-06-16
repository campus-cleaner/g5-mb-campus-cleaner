import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtil {
  static Future<File> getFileFromAsset(
      String assetPath, String fileName) async {
    // Load image bytes from assets
    ByteData byteData = await rootBundle.load(assetPath);
    Uint8List bytes = byteData.buffer.asUint8List();

    // Get the temporary directory
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = File('$tempPath/$fileName');

    // Write the bytes to the file
    await file.writeAsBytes(bytes, flush: true);

    return file;
  }
}

import 'package:g5_mb_campus_cleaner/global/env.dart';

class FileService {
  static String getUrlImageFromServer(String filename) {
    return '${Environment.apiUrl}/s3/downloadS3File?fileName=$filename';
  }
}

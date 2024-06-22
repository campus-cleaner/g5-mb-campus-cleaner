import 'package:intl/intl.dart';

class FormatTextUtil {
  static String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
    return formatter.format(dateTime);
  }

  static String formatFileName(String token, DateTime dateTime) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd-HH-mm');
    return "$token-${formatter.format(dateTime)}";
  }
}

import 'package:logger/logger.dart';

class LoggerUtil {
  static final Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  static void logInfo(String message) {
    logger.i(message);
  }

  static void logDebug(String message) {
    logger.d(message);
  }

  static void logWarning(String message) {
    logger.w(message);
  }

  static void logError(String message) {
    logger.e(message);
  }

  static void logVerbose(String message) {
    logger.v(message);
  }
}

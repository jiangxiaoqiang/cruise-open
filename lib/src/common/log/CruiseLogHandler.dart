import 'package:Cruise/src/common/Repo.dart';
import 'package:logger/logger.dart';

class CruiseLogHandler {
  static Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  static Future<void> logError(CruiseApiError error, String message) async {
    logger.e(message);
  }

  static Future<void> logWaring(String message) async {
    logger.w(message);
  }

  static Future<void> logDebugging(CruiseApiError error, String message) async {
    logger.d(message);
  }
}

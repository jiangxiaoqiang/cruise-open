import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:logger/logger.dart';

import 'cruise_api_error.dart';

class CruiseLogHandler {
  static Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  static Future<void> logErrorException(String message, Exception e) async {
    logger.e(message, e);
    FirebaseCrashlytics.instance.log(message);
  }

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

import 'package:Cruise/src/common/Repo.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CruiseLogHandler {
  static Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  static Future<void> logError(CruiseApiError error, String message) async {
    logger.e(message);
    await Sentry.captureException(
      error,
      stackTrace: message,
    );
  }

  static Future<void> logWaring(String message) async {
    logger.w(message);
  }

  static Future<void> logDebugging(CruiseApiError error, String message) async {
    logger.d(message);
    await Sentry.captureException(
      error,
      stackTrace: message,
    );
  }
}

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import 'cruise_api_error.dart';

class CruiseLogHandler1 {
  static Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  static Future<void> logErrorException(String message, Object e) async {
    FirebaseCrashlytics.instance.log(message);
  }

  static Future<void> logErrorStack(String message, StackTrace e) async {
    FirebaseCrashlytics.instance.log(message+","+e.toString());
  }

  static Future<void> logFlutterErrorDetails(FlutterErrorDetails details) async {
    FirebaseCrashlytics.instance.log(details.toString());
  }

  static Future<void> logError(CruiseApiError error, String message) async {
    FirebaseCrashlytics.instance.log(message);
  }

  static Future<void> logWaring(String message) async {
    logger.w(message);
  }

  static Future<void> logDebugging(CruiseApiError error, String message) async {
    logger.d(message);
  }
}

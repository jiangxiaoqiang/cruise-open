

import 'package:Cruise/src/common/Repo.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CruiseLogHandler{

  static Future<void> logError(CruiseApiError error,String message) async {
    await Sentry.captureException(
      error,
      stackTrace: message,
    );
  }


}


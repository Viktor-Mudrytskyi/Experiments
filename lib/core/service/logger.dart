import 'dart:developer';

import 'package:flutter/foundation.dart';

class Logger {
  // White text
  static void logInfo(Object? msg) {
    if (kDebugMode) {
      log('\x1B[37m${msg.toString()}\x1B[0m');
    }
  }

  // Green text

  static void logSuccess(Object? msg) {
    if (kDebugMode) {
      log('\x1B[32m${msg.toString()}\x1B[0m');
    }
  }

  // Yellow text
  static void logWarning(Object? msg) {
    if (kDebugMode) {
      log('\x1B[33m${msg.toString()}\x1B[0m');
    }
  }

  // Red text
  static void logError(Object? msg) {
    if (kDebugMode) {
      log('\x1B[31m ERROR: ${msg.toString()}\x1B[0m');
    }
  }
}

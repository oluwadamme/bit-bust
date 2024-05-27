import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class ErrorHandling {
  static void init() {
    const fatalError = true;
    if (kDebugMode) {
      return;
    }
    // Non-async exceptions
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(fatalError);
      if (fatalError) {
        // If you want to record a "fatal" exception
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        // ignore: dead_code
      } else {
        // If you want to record a "non-fatal" exception
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      }
    };
    // Async exceptions
    PlatformDispatcher.instance.onError = (error, stack) {
      if (fatalError) {
        // If you want to record a "fatal" exception
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        // ignore: dead_code
      } else {
        // If you want to record a "non-fatal" exception
        FirebaseCrashlytics.instance.recordError(error, stack);
      }
      return true;
    };
  }
}

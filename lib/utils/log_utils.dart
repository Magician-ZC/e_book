import 'package:flutter/foundation.dart';

class LogUtils {
  static bool isOpenLog = kDebugMode;

  static void println(String obj) {
    if (isOpenLog) debugPrint(obj);
  }

  static void logger(String obj, {StackTrace? stackTrace, int level = 0}) {
    if (isOpenLog) logger(obj, stackTrace: stackTrace, level: level);
  }
}

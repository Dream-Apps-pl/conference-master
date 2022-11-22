import 'package:flutter/foundation.dart';
import 'package:flutter_bugfender/flutter_bugfender.dart';
import 'package:stack_trace/stack_trace.dart';

class Logger {
  bool printToConsole = false;

  void info(String message) {
    final className = Trace.current().frames[1].member?.split(".")[0];
    final methodName = Trace.current().frames[1].member?.split(".")[1];
    if (printToConsole) debugPrint(message);
    FlutterBugfender.sendLog(
        text: message,
        level: LogLevel.info,
        tag: className!,
        method: methodName!);
  }

  void error(String message) {
    final className = Trace.current().frames[1].member?.split(".")[0];
    final methodName = Trace.current().frames[1].member?.split(".")[1];
    if (printToConsole) debugPrint(message);
    FlutterBugfender.sendLog(
        text: message,
        level: LogLevel.error,
        tag: className!,
        method: methodName!);
    FlutterBugfender.forceSendOnce();
  }

  void errorException(Object e, [StackTrace? s]) {
    if (printToConsole) print(e);
    if (printToConsole) print(s);

    FlutterBugfender.error('Exception: $e.\nStacktrace: $s');
    FlutterBugfender.forceSendOnce();
  }

  void warn(String message) {
    final className = Trace.current().frames[1].member?.split(".")[0];
    final methodName = Trace.current().frames[1].member?.split(".")[1];
    if (printToConsole) debugPrint(message);
    FlutterBugfender.sendLog(
        text: message,
        level: LogLevel.warning,
        tag: className!,
        method: methodName!);
    FlutterBugfender.forceSendOnce();
  }

  void setDeviceString(String key, String userId) {
    FlutterBugfender.setDeviceString(key, userId);
  }
}

Logger logger = Logger();

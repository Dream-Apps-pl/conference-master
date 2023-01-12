import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

class Logger {
  bool printToConsole = false;

  void info(String message) {
    final className = Trace.current().frames[1].member?.split(".")[0];
    final methodName = Trace.current().frames[1].member?.split(".")[1];
    if (printToConsole) debugPrint(message);
  }

  void error(String message) {
    final className = Trace.current().frames[1].member?.split(".")[0];
    final methodName = Trace.current().frames[1].member?.split(".")[1];
    if (printToConsole) debugPrint(message);
  }

  void errorException(Object e, [StackTrace? s]) {
    if (printToConsole) Logger().info(e.toString());
    if (printToConsole) Logger().info(s.toString());
  }

  void warn(String message) {
    if (printToConsole) debugPrint(message);
  }

  void setDeviceString(String key, String userId) {}
}

Logger logger = Logger();

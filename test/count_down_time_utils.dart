import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: avoid_relative_lib_imports
import '../example/lib/count_down_time_example.dart';

/// A constant that is used to limit the number of times the `waitForTimeRender` function is called.
const retryLimit = 10;

/// It will call the callback function passed in, and if it returns false, it will wait for a second and
/// then call the callback function again. It will do this up to 10 times
///
/// Args:
///   callbackFind (Function()): A function that returns a Future<bool> that will be called to determine
/// if the widget has been rendered.
///   tester: The WidgetTester object
///   retries (int): The number of times the function has been called.
///
/// Returns:
///   A Future<bool>
Future<bool> waitForTimeRender(
    Function() callbackFind, tester, int? retries) async {
  final retriesUpdated = (retries ?? 0) + 1;
  final found = await callbackFind();

  if (found) {
    return found;
  }

  if (retriesUpdated < retryLimit) {
    await tester.pump(const Duration(milliseconds: 1000));
    return await waitForTimeRender(callbackFind, tester, retriesUpdated);
  }
  return false;
}

/// A function that will create the app with the parameters passed in.
Future<void> makeApp(
  WidgetTester tester, {
  Color? color = Colors.black,
  double? fontSize = 15,
  int? timeStartInSeconds,
  int? timeStartInMinutes,
  int? timeStartInHours,
}) async {
  /// Checking if has timeStartInMinutes.
  final hasTimeStartInMinutes = timeStartInMinutes != null;

  /// Checking if has timeStartInHours.
  final hasTimeStartInHours = timeStartInHours != null;

  if (hasTimeStartInHours) {
    await tester.pumpWidget(
      MaterialApp(
        home: CountDownTimeApp.hours(
          textStyle: TextStyle(
            color: color ?? Colors.black,
            fontSize: fontSize ?? 15,
          ),
          timeStartInHours: timeStartInHours,
        ),
      ),
    );
  } else if (hasTimeStartInMinutes) {
    await tester.pumpWidget(
      MaterialApp(
        home: CountDownTimeApp.minutes(
          textStyle: TextStyle(
            color: color ?? Colors.black,
            fontSize: fontSize ?? 15,
          ),
          timeStartInMinutes: timeStartInMinutes,
        ),
      ),
    );
  } else {
    await tester.pumpWidget(
      MaterialApp(
        home: CountDownTimeApp(
          textStyle: TextStyle(
            color: color ?? Colors.black,
            fontSize: fontSize ?? 15,
          ),
          timeStartInSeconds: timeStartInSeconds ?? 30,
        ),
      ),
    );
  }
  await tester.pumpAndSettle();
}

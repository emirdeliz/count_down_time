import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: avoid_relative_lib_imports
import '../count_down_time_demo/lib/count_down_time_app.dart';

const retryLimit = 10;

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

Future<void> makeApp(WidgetTester tester,
    {Color? color = Colors.black,
    double? fontSize = 15,
    int? timeStartInSeconds,
    int? timeStartInMinutes,
    int? timeStartInHours}) async {
  final hasTimeStartInMinutes = timeStartInMinutes != null;
  final hasTimeStartInHours = timeStartInHours != null;

  if (hasTimeStartInHours) {
    await tester.pumpWidget(MaterialApp(
        home: CountDownTimeApp.hours(
            id: 'test-1',
            color: color ?? Colors.black,
            fontSize: fontSize ?? 15,
            timeStartInHours: timeStartInHours)));
  } else if (hasTimeStartInMinutes) {
    await tester.pumpWidget(MaterialApp(
        home: CountDownTimeApp.minutes(
            id: 'test-1',
            color: color ?? Colors.black,
            fontSize: fontSize ?? 15,
            timeStartInMinutes: timeStartInMinutes)));
  } else {
    await tester.pumpWidget(MaterialApp(
        home: CountDownTimeApp(
            id: 'test-1',
            color: color ?? Colors.black,
            fontSize: fontSize ?? 15,
            timeStartInSeconds: timeStartInSeconds ?? 30)));
  }
  await tester.pumpAndSettle();
}

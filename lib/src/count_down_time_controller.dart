import 'dart:async';
import 'package:count_down_time/count_down_time.dart';
import 'package:flutter/cupertino.dart';

class CountDownTimeController extends ChangeNotifier {
  int timeStartInSeconds = 0;
  int currentTimerSeconds = 0;
  Timer? timerInstance;

  CountDownTimeController({this.timeStartInSeconds = 15});

  void startTimer(int timerDefaultValue, Function(int) timeCallback) {
    currentTimerSeconds = timeStartInSeconds;
    timerInstance = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        setCurrentTimeInSeconds(currentTimerSeconds - 1);
        timeCallback(currentTimerSeconds);
      },
    );
  }

  void stopTimer() {
    timerInstance?.cancel();
  }

  void setTimeStartInSeconds(int value) {
    timeStartInSeconds = value;
  }

  void setCurrentTimeInSeconds(int value) {
    currentTimerSeconds = value;
    notifyListeners();
  }

  int getCurrentTimeInSeconds() {
    return currentTimerSeconds;
  }

  String getCurrentTimeInSecondsFormatted() {
    return formatSecondsToTime(currentTimerSeconds, timeStartInSeconds);
  }

  void resetTimer() {
    currentTimerSeconds = timeStartInSeconds;
  }

  void maybeUpdateTimeStart(covariant CountDownTime oldWidget) {
    final hasNewTimeStart = oldWidget.timeStartInSeconds != timeStartInSeconds;
    if (hasNewTimeStart) {
      resetTimer();
    }
  }

  String formatSecondsToTime(int timeInSecond, int timeStartInSeconds) {
    DateTime dateBase = DateTime(2000, 1, 1, 0, 0, timeInSecond);
    int second = dateBase.second;
    int minute = dateBase.minute;
    int hour = dateBase.hour;

    bool showHours = (timeStartInSeconds / 3600).floor() > 0;

    String secondStr = second.toString().length <= 1 ? "0$second" : "$second";
    String minuteStr = minute.toString().length <= 1 ? "0$minute" : "$minute";
    String hourStr = hour.toString().length <= 1 ? "0$hour" : "$hour";
    return "${showHours ? '$hourStr:' : ''}$minuteStr:$secondStr";
  }
}

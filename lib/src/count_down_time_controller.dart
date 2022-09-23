import 'dart:async';
import 'package:count_down_time/count_down_time.dart';
import 'package:flutter/material.dart';

/// > This class is a ChangeNotifier that has a `start()` method that starts a timer that counts down
/// from a given duration and notifies listeners when the timer is done
class CountDownTimeController extends ChangeNotifier {
  int timeStartInSeconds = 0;
  int currentTimerSeconds = 0;
  Timer? timerInstance;

  /// StartTimer takes an int and an optional function that takes an int and returns nothing, and
  /// returns nothing.
  ///
  /// Args:
  ///   timerDefaultValue (int): The default value of the timer.
  ///   timeCallback (Function(int)?): This is the function that will be called every second.
  void startTimer(int timerDefaultValue, [Function(int)? timeCallback]) {
    /// Checking if has a timer running.
    bool hasTimerInstanceRunning = timerInstance != null;
    if (hasTimerInstanceRunning) {
      /// Cancelling the timer.
      timerInstance?.cancel();
    }

    /// Resetting the currentTimerSeconds.
    currentTimerSeconds = timeStartInSeconds;

    /// Creating a timer that will call the function passed as the second argument every second.
    timerInstance = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        setCurrentTimeInSeconds(currentTimerSeconds - 1);
        if (timeCallback != null) {
          timeCallback(currentTimerSeconds);
        }
      },
    );
  }

  /// If the timer instance is not null, cancel it
  void stopTimer() {
    timerInstance?.cancel();
  }

  /// It sets the timeStartInSeconds variable to the value passed in.
  ///
  /// Args:
  ///   value (int): The value of the parameter.
  void setTimeStartInSeconds(int value) {
    timeStartInSeconds = value;
  }

  /// If the value is greater than or equal to 0, set the currentTimerSeconds to the value, otherwise set
  /// it to 0
  ///
  /// Args:
  ///   value (int): The new value of the timer.
  void setCurrentTimeInSeconds(int value) {
    currentTimerSeconds = value >= 0 ? value : 0;
    notifyListeners();
  }

  /// `getCurrentTimeInSeconds()` returns the current time in seconds
  ///
  /// Returns:
  ///   The current time in seconds.
  int getCurrentTimeInSeconds() {
    return currentTimerSeconds;
  }

  /// It returns the current time in seconds formatted.
  ///
  /// Returns:
  ///   The current time in seconds formatted.
  /// It returns the current time in seconds.
  String getCurrentTimeInSecondsFormatted() {
    return formatSecondsToTime(currentTimerSeconds, timeStartInSeconds);
  }

  void resetTimer() {
    currentTimerSeconds = timeStartInSeconds;
  }

  /// If the timeStartInSeconds value has changed, reset the timer
  ///
  /// Args:
  ///   oldWidget (CountDownTime): The previous instance of this widget.
  void maybeUpdateTimeStart(covariant CountDownTime oldWidget) {
    final hasNewTimeStart = oldWidget.timeStartInSeconds != timeStartInSeconds;
    if (hasNewTimeStart) {
      resetTimer();
    }
  }

  /// It takes in two integers and returns a string.
  ///
  /// Args:
  ///   timeInSecond (int): The time in seconds that you want to convert to a time string.
  ///   timeStartInSeconds (int): The time in seconds that the video started at.
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

import 'dart:async';

class CountDownTimeController {
  int _currentTimeInSeconds = 0;
  String _countDownTimeId = '';
  static final List<String> _countDownTimeRenewld =
      List<String>.empty(growable: true);

  static String popCountDownTimeRenewId(String timerId) {
    int indexValue = _countDownTimeRenewld.indexOf(timerId);
    return indexValue > -1
        ? _countDownTimeRenewld.removeAt(indexValue)
        : indexValue.toString();
  }

  static List<String> getResetCountDownTimeRenewld() {
    return _countDownTimeRenewld;
  }

  static void pushTimerRenewId(String timerId) {
    _countDownTimeRenewld.add(timerId);
  }

  static formatSecondsToTime(int timeInSecond, int timeStartInSeconds) {
    int second = timeInSecond % 60;
    int minute = (timeInSecond / 60).floor();
    int hour = (minute / 60).floor();

    bool showMinutes = (timeStartInSeconds / 60).floor() > 0;
    bool showHours = (timeStartInSeconds / 60 / 60).floor() > 0;

    String secondStr = second.toString().length <= 1 ? "0$second" : "$second";
    String minuteStr = minute.toString().length <= 1 ? "0$minute" : "$minute";
    String hourStr = minute.toString().length <= 1 ? "0$hour" : "$hour";
    return "${showHours ? '$hourStr:' : ''}${showMinutes ? '$minuteStr:' : ''}$secondStr";
  }

  void setId(String id) {
    _countDownTimeId = id;
  }

  int getCurrentTimeInSeconds() {
    return _currentTimeInSeconds;
  }

  void startTimer(int timerDefaultValue, Function(int, Timer) timeCallback) {
    const oneSecondDurantion = Duration(seconds: 1);
    Timer.periodic(
      oneSecondDurantion,
      (Timer timer) {
        final timerResetPending =
            CountDownTimeController.popCountDownTimeRenewId(_countDownTimeId);
        _currentTimeInSeconds = timerResetPending != '-1'
            ? timerDefaultValue
            : _currentTimeInSeconds - 1;
        timeCallback(_currentTimeInSeconds, timer);
      },
    ).hashCode;
  }
}

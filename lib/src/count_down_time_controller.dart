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

  static formatSecondsToTime(int timeInSecond) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
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

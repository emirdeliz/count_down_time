import 'dart:async';

class CountDownTimeController {
  int _currentTimeInSeconds = 0;
  String _countDownTimeId = '';
  Timer? _timerInstance;

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

  void setId(String id) {
    _countDownTimeId = id;
  }

  int getCurrentTimeInSeconds() {
    return _currentTimeInSeconds;
  }

  void setCurrentTimeInSeconds(int time) {
    _currentTimeInSeconds = time;
  }

  void startTimer(int timerDefaultValue, Function(int, Timer) timeCallback) {
    const oneSecondDurantion = Duration(seconds: 1);
    _timerInstance = Timer.periodic(
      oneSecondDurantion,
      (Timer timer) {
        final timerResetPending =
            CountDownTimeController.popCountDownTimeRenewId(_countDownTimeId);
        _currentTimeInSeconds = timerResetPending != '-1'
            ? timerDefaultValue
            : _currentTimeInSeconds - 1;
        timeCallback(_currentTimeInSeconds, timer);
      },
    );
  }

  void stopTimer() {
    _timerInstance?.cancel();
  }
}

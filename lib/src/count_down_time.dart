import 'package:count_down_time/src/count_down_time_controller.dart';
import 'package:flutter/material.dart';

class CountDownTime extends StatefulWidget {
  final int timeStartInSeconds;
  final String timeId;
  final double? fontSize;
  final Color? color;
  final Function(int time)? onChangeTime;
  final Function() onTimeOut;

  const CountDownTime({
    Key? key,
    this.timeStartInSeconds = 15, // or 15 minutes
    this.color,
    this.fontSize,
    this.onChangeTime,
    required this.onTimeOut,
    required this.timeId,
  }) : super(key: key);

  @override
  State<CountDownTime> createState() {
    return _CountDownTimeState();
  }

  factory CountDownTime.minutes(
      {int? timeStartInMinutes,
      double? fontSize,
      Color? color,
      Function(int time)? onChangeTime,
      required String timeId,
      required Function() onTimeOut}) {
    return CountDownTime(
        timeId: timeId,
        timeStartInSeconds: (timeStartInMinutes ?? 1) * 60,
        fontSize: fontSize,
        color: color,
        onChangeTime: onChangeTime,
        onTimeOut: onTimeOut);
  }

  factory CountDownTime.hours(
      {int? timeStartInHours,
      double? fontSize,
      Color? color,
      Function(int time)? onChangeTime,
      required String timeId,
      required Function() onTimeOut}) {
    return CountDownTime.minutes(
        timeId: timeId,
        timeStartInMinutes: (timeStartInHours ?? 1) * 60 * 60,
        fontSize: fontSize,
        color: color,
        onChangeTime: onChangeTime,
        onTimeOut: onTimeOut);
  }
}

class _CountDownTimeState extends State<CountDownTime> {
  int _currentTimerSeconds = 0;
  CountDownTimeController timeController = CountDownTimeController();

  void _initialize() {
    timeController.setId(widget.timeId);
    _renewTimer();
    _startTimer();

    final onChangeTime = widget.onChangeTime;
    if (onChangeTime != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onChangeTime(timeController.getCurrentTimeInSeconds());
      });
    }
  }

  void _renewTimer() {
    CountDownTimeController.pushTimerRenewId(widget.timeId);
  }

  void _startTimer() {
    timeController.startTimer(widget.timeStartInSeconds, (timeCurrent, timer) {
      setState(() {
        _currentTimerSeconds = timeCurrent;
      });
      final bool reachedTimeOut = timeCurrent == 0;
      if (reachedTimeOut) {
        timer.cancel();
        widget.onTimeOut();
      }
    });
  }

  Widget _buildTimerCount() {
    final String time = CountDownTimeController.formatSecondsToTime(
        _currentTimerSeconds, widget.timeStartInSeconds);
    return Text(
      time,
      style: TextStyle(
        color: widget.color,
        fontSize: widget.fontSize,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTimerCount();
  }
}

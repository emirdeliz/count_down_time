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
    this.timeStartInSeconds = 15 * 60, // or 15 minutes
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
        timeStartInSeconds: timeStartInMinutes ?? 1 * 60,
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
        timeStartInMinutes: timeStartInHours ?? 1 * 60,
        fontSize: fontSize,
        color: color,
        onChangeTime: onChangeTime,
        onTimeOut: onTimeOut);
  }
}

class _CountDownTimeState extends State<CountDownTime> {
  CountDownTimeController timeController = CountDownTimeController();

  void initialize() {
    timeController.setId(widget.timeId);
    renewTimer();
    startTimer();

    final onChangeTime = widget.onChangeTime;
    if (onChangeTime != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onChangeTime(timeController.getCurrentTimeInSeconds());
      });
    }
  }

  void renewTimer() {
    CountDownTimeController.pushTimerRenewId(widget.timeId);
  }

  void startTimer() {
    timeController.startTimer(widget.timeStartInSeconds, (timeCurrent, timer) {
      final bool reachedTimeOut = timeCurrent == 0;
      if (reachedTimeOut) {
        timer.cancel();
        widget.onTimeOut();
      }
    });
  }

  Widget _buildTimerCount() {
    final String time = CountDownTimeController.formatSecondsToTime(
        timeController.getCurrentTimeInSeconds());
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
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTimerCount();
  }
}

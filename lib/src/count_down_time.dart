import 'package:count_down_time/count_down_time.dart';
import 'package:flutter/material.dart';

class CountDownTime extends StatefulWidget {
  final int timeStartInSeconds;
  final double? fontSize;
  final Color? color;
  final CountDownTimeController? controller;
  final Function(int time)? onChangeTime;
  final Function()? onTimeOut;

  const CountDownTime({
    Key? key,
    this.timeStartInSeconds = 15, // or 15 seconds
    this.color,
    this.fontSize,
    this.controller,
    this.onChangeTime,
    this.onTimeOut,
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
      required Function() onTimeOut}) {
    return CountDownTime(
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
      required Function() onTimeOut}) {
    return CountDownTime.minutes(
        timeStartInMinutes: (timeStartInHours ?? 1) * 60,
        fontSize: fontSize,
        color: color,
        onChangeTime: onChangeTime,
        onTimeOut: onTimeOut);
  }
}

class _CountDownTimeState extends State<CountDownTime>
    with SingleTickerProviderStateMixin {
  String currentTimeInSecondsFormatted = '';
  late CountDownTimeController _controller;

  void _initialize() {
    _controller = widget.controller ??
        CountDownTimeController(timeStartInSeconds: widget.timeStartInSeconds);
    _initializeCountDownTimeProps();
    _initializeCountDownTimeControllerListener();
    _startTimer();
  }

  void _initializeCountDownTimeProps() {
    final onChangeTime = widget.onChangeTime;
    if (onChangeTime != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onChangeTime(_controller.getCurrentTimeInSeconds());
      });
    }
  }

  void _initializeCountDownTimeControllerListener() {
    _controller.addListener(() {
      setState(() {
        currentTimeInSecondsFormatted =
            _controller.getCurrentTimeInSecondsFormatted();
      });
    });
  }

  void _startTimer() {
    _controller.startTimer(widget.timeStartInSeconds, (timeCurrent) {
      final reachedTimeOut = timeCurrent < 0;
      if (reachedTimeOut) {
        _controller.stopTimer();
        final onTimeOut = widget.onTimeOut;
        if (onTimeOut != null) {
          onTimeOut();
        }
      }
    });
  }

  Widget _buildTimerCount() {
    return Text(
      currentTimeInSecondsFormatted,
      style: TextStyle(
        color: widget.color,
        fontSize: widget.fontSize,
      ),
    );
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CountDownTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.maybeUpdateTimeStart(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTimerCount();
  }
}

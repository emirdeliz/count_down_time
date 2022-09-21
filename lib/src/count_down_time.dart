import 'package:count_down_time/count_down_time.dart';
import 'package:flutter/material.dart';

class CountDownTime extends StatefulWidget {
  final int timeStartInSeconds;
  final TextStyle? textStyle;
  final CountDownTimeController? controller;
  final Function(int time)? onChangeTime;
  final Function()? onTimeOut;

  const CountDownTime({
    Key? key,
    this.timeStartInSeconds = 15, // or 15 seconds
    this.textStyle,
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
      TextStyle? textStyle,
      Function(int time)? onChangeTime,
      required Function() onTimeOut}) {
    return CountDownTime(
        timeStartInSeconds: (timeStartInMinutes ?? 1) * 60,
        textStyle: textStyle,
        onChangeTime: onChangeTime,
        onTimeOut: onTimeOut);
  }

  factory CountDownTime.hours(
      {int? timeStartInHours,
      TextStyle? textStyle,
      Function(int time)? onChangeTime,
      required Function() onTimeOut}) {
    return CountDownTime.minutes(
        timeStartInMinutes: (timeStartInHours ?? 1) * 60,
        textStyle: textStyle,
        onChangeTime: onChangeTime,
        onTimeOut: onTimeOut);
  }
}

class _CountDownTimeState extends State<CountDownTime>
    with SingleTickerProviderStateMixin {
  String currentTimeInSecondsFormatted = '';
  late CountDownTimeController _controller;

  void _initialize() {
    _controller = widget.controller ?? CountDownTimeController();
    _controller.setTimeStartInSeconds(widget.timeStartInSeconds);

    _startTimer();
    _initializeCountDownTimeControllerListener();
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
      _maybeTriggerOnChangeTimeProp();
      final reachedTimeOut = timeCurrent <= 0;
      if (reachedTimeOut) {
        _maybeTriggerOnTimeOutProp();
        _controller.stopTimer();
      }
    });
  }

  Widget _buildTimerCount() {
    return Text(
      currentTimeInSecondsFormatted,
      style: widget.textStyle ??
          const TextStyle(
            fontSize: 10,
          ),
    );
  }

  void _maybeTriggerOnTimeOutProp() {
    final onTimeOut = widget.onTimeOut;
    if (onTimeOut != null) {
      onTimeOut();
    }
  }

  void _maybeTriggerOnChangeTimeProp() {
    final onChangeTime = widget.onChangeTime;
    if (onChangeTime != null) {
      onChangeTime(_controller.getCurrentTimeInSeconds());
    }
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

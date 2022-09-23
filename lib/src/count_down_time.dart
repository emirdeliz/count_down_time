import 'package:count_down_time/count_down_time.dart';
import 'package:flutter/material.dart';

class CountDownTime extends StatefulWidget {
  /// A variable that is used to set the time that the timer will start at.
  final int timeStartInSeconds;

  /// Custom textStyle to the widget.
  final TextStyle? textStyle;

  /// Custom controller to the widget.
  final CountDownTimeController? controller;

  /// Callback function runs when the time is changed.
  final Function(int time)? onChangeTime;

  /// Callback function runs when the count down is done.
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

  /// A factory constructor to build a CountDownTime using minutes as the start time.
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

  /// A factory constructor to build a CountDownTime using hours as the start time.
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
  /// A variable that is used to store the current time in seconds formatted.
  String currentTimeInSecondsFormatted = '';

  /// A default count down controller.
  late CountDownTimeController _controller;

  /// Initialize the count down widget.
  void _initialize() {
    _controller = widget.controller ?? CountDownTimeController();
    _controller.setTimeStartInSeconds(widget.timeStartInSeconds);

    _startTimer();
    _initializeCountDownTimeControllerListener();
  }

  /// It initializes the listener for the countDownTimeController.
  /// Update the current time to display on the widget.
  void _initializeCountDownTimeControllerListener() {
    _controller.addListener(() {
      setState(() {
        currentTimeInSecondsFormatted =
            _controller.getCurrentTimeInSecondsFormatted();
      });
    });
  }

  /// Starts a timer that counts down from the time specified in the timeStartInSeconds variable.
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

  /// It returns a widget that displays the current time in a Text widget.
  Widget _buildTimerCount() {
    return Text(
      currentTimeInSecondsFormatted,
      style: widget.textStyle ??
          const TextStyle(
            fontSize: 10,
          ),
    );
  }

  /// If the `onTimeout` property is set, then call it
  void _maybeTriggerOnTimeOutProp() {
    final onTimeOut = widget.onTimeOut;
    if (onTimeOut != null) {
      onTimeOut();
    }
  }

  /// If the time prop has changed, trigger the onChangeTime prop
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

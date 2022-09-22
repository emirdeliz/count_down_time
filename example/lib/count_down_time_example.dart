import 'package:flutter/material.dart';
import 'package:count_down_time/count_down_time.dart';

class CountDownTimeApp extends StatefulWidget {
  final TextStyle textStyle;
  final int timeStartInSeconds;

  const CountDownTimeApp(
      {Key? key, required this.textStyle, required this.timeStartInSeconds})
      : super(key: key);

  @override
  State<CountDownTimeApp> createState() {
    return _CountDownTimeAppState();
  }

  factory CountDownTimeApp.minutes(
      {required int timeStartInMinutes, required TextStyle textStyle}) {
    return CountDownTimeApp(
        timeStartInSeconds: timeStartInMinutes * 60, textStyle: textStyle);
  }

  factory CountDownTimeApp.hours({
    required int timeStartInHours,
    required TextStyle textStyle,
  }) {
    return CountDownTimeApp.minutes(
        timeStartInMinutes: timeStartInHours * 60, textStyle: textStyle);
  }
}

class _CountDownTimeAppState extends State<CountDownTimeApp> {
  bool timeoutReached = false;
  CountDownTimeController? controller = CountDownTimeController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CountDownTime(
          textStyle: widget.textStyle,
          controller: controller,
          timeStartInSeconds: widget.timeStartInSeconds,
          onChangeTime: (time) {
            setState(() {
              timeoutReached = false;
            });
          },
          onTimeOut: () {
            setState(() {
              timeoutReached = true;
            });
          },
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          child: ElevatedButton(
            child: const Text('Restart count'),
            onPressed: () {
              setState(() {
                timeoutReached = false;
              });
              controller?.startTimer(widget.timeStartInSeconds);
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(timeoutReached ? 'Timeout Reached' : ''))
      ],
    );
  }
}

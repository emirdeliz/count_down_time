import 'package:flutter/material.dart';
import 'package:count_down_time/count_down_time.dart';

class CountDownTimeApp extends StatefulWidget {
  final Color color;
  final double fontSize;
  final int timeStartInSeconds;

  const CountDownTimeApp(
      {Key? key,
      required this.color,
      required this.fontSize,
      required this.timeStartInSeconds})
      : super(key: key);

  @override
  State<CountDownTimeApp> createState() {
    return _CountDownTimeAppState();
  }

  factory CountDownTimeApp.minutes(
      {required int timeStartInMinutes,
      required double fontSize,
      required Color color}) {
    return CountDownTimeApp(
        timeStartInSeconds: timeStartInMinutes * 60,
        fontSize: fontSize,
        color: color);
  }

  factory CountDownTimeApp.hours({
    required int timeStartInHours,
    required double fontSize,
    required Color color,
  }) {
    return CountDownTimeApp.minutes(
        timeStartInMinutes: timeStartInHours * 60,
        fontSize: fontSize,
        color: color);
  }
}

class _CountDownTimeAppState extends State<CountDownTimeApp> {
  bool timeoutReached = false;
  CountDownTimeController controller = CountDownTimeController();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CountDownTime(
            color: widget.color,
            fontSize: widget.fontSize,
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
                  controller.resetTimer();
                },
              )),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(timeoutReached ? 'Timeout Reached' : ''))
        ]);
  }
}

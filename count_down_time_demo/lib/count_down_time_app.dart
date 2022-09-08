import 'package:flutter/material.dart';
import 'package:count_down_time/count_down_time.dart';

class CountDownTimeApp extends StatefulWidget {
  final String id;
  final Color color;
  final double fontSize;
  final int timeStartInSeconds;

  const CountDownTimeApp(
      {Key? key,
      required this.id,
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
      required Color color,
      required String id}) {
    return CountDownTimeApp(
        id: id,
        timeStartInSeconds: timeStartInMinutes * 60,
        fontSize: fontSize,
        color: color);
  }

  factory CountDownTimeApp.hours({
    required int timeStartInHours,
    required double fontSize,
    required Color color,
    required String id,
  }) {
    return CountDownTimeApp.minutes(
        id: id,
        timeStartInMinutes: timeStartInHours * 60,
        fontSize: fontSize,
        color: color);
  }
}

class _CountDownTimeAppState extends State<CountDownTimeApp> {
  bool timeoutReached = false;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CountDownTime(
            timeId: widget.id,
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
                  CountDownTimeController.pushTimerRenewId(widget.id);
                },
              )),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(timeoutReached ? 'Timeout Reached' : ''))
        ]);
  }
}

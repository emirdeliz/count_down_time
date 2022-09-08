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
}

class _CountDownTimeAppState extends State<CountDownTimeApp> {
  bool timeoutReached = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
        }, // 15minutes
      ),
      Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ElevatedButton(
            child: const Text('Renew session'),
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

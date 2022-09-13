import 'package:count_down_time_demo/count_down_time_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CountDownTimeAppDemo());
}

class CountDownTimeAppDemo extends StatefulWidget {
  const CountDownTimeAppDemo({Key? key}) : super(key: key);

  @override
  State<CountDownTimeAppDemo> createState() => _CountDownTimeAppDemoState();
}

class _CountDownTimeAppDemoState extends State<CountDownTimeAppDemo> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Count Down Time Demo'),
        ),
        body: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const CountDownTimeApp(
                    color: Colors.red, fontSize: 35, timeStartInSeconds: 30),
                CountDownTimeApp.minutes(
                    color: Colors.red, fontSize: 35, timeStartInMinutes: 2),
                CountDownTimeApp.hours(
                    color: Colors.red, fontSize: 35, timeStartInHours: 2)
              ],
            )),
      ),
    );
  }
}

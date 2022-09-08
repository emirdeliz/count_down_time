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
        body: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                const CountDownTimeApp(
                    id: 'test-1',
                    color: Colors.red,
                    fontSize: 35,
                    timeStartInSeconds: 30),
                CountDownTimeApp.minutes(
                    id: 'test-2',
                    color: Colors.red,
                    fontSize: 35,
                    timeStartInMinutes: 15),
                CountDownTimeApp.hours(
                    id: 'test-3',
                    color: Colors.red,
                    fontSize: 35,
                    timeStartInHours: 1)
              ],
            )),
      ),
    );
  }
}

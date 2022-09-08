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
          title: const Text('Plugin example app'),
        ),
        body: Row(
          children: const [
            CountDownTimeApp(
                id: 'test-1',
                color: Colors.red,
                fontSize: 35,
                timeStartInSeconds: 15 * 50)
          ],
        ),
      ),
    );
  }
}

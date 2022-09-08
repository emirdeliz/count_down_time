import 'package:flutter/material.dart';
import 'package:count_down_time/count_down_time.dart';

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
          children: [
            CountDownTimeApp(
                id: 'test-1',
                color: Colors.red,
                fontSize: 15,
                timeStartInSeconds: 15 * 50)
          ],
        ),
      ),
    );
  }
}

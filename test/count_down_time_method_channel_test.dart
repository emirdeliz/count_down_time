import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:count_down_time/count_down_time_method_channel.dart';

void main() {
  MethodChannelCountDownTime platform = MethodChannelCountDownTime();
  const MethodChannel channel = MethodChannel('count_down_time');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}

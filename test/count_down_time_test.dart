import 'package:flutter_test/flutter_test.dart';
import 'package:count_down_time/count_down_time.dart';
import 'package:count_down_time/count_down_time_platform_interface.dart';
import 'package:count_down_time/count_down_time_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCountDownTimePlatform 
    with MockPlatformInterfaceMixin
    implements CountDownTimePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CountDownTimePlatform initialPlatform = CountDownTimePlatform.instance;

  test('$MethodChannelCountDownTime is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCountDownTime>());
  });

  test('getPlatformVersion', () async {
    CountDownTime countDownTimePlugin = CountDownTime();
    MockCountDownTimePlatform fakePlatform = MockCountDownTimePlatform();
    CountDownTimePlatform.instance = fakePlatform;
  
    expect(await countDownTimePlugin.getPlatformVersion(), '42');
  });
}

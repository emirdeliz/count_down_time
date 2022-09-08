import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apps/apps_method_channel.dart';

void main() {
  MethodChannelApps platform = MethodChannelApps();
  const MethodChannel channel = MethodChannel('apps');

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

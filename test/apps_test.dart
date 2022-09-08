import 'package:flutter_test/flutter_test.dart';
import 'package:apps/apps.dart';
import 'package:apps/apps_platform_interface.dart';
import 'package:apps/apps_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppsPlatform
    with MockPlatformInterfaceMixin
    implements AppsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AppsPlatform initialPlatform = AppsPlatform.instance;

  test('$MethodChannelApps is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelApps>());
  });

  test('getPlatformVersion', () async {
    Apps appsPlugin = Apps();
    MockAppsPlatform fakePlatform = MockAppsPlatform();
    AppsPlatform.instance = fakePlatform;

    expect(await appsPlugin.getPlatformVersion(), '42');
  });
}

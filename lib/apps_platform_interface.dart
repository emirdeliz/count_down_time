import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'apps_method_channel.dart';

abstract class AppsPlatform extends PlatformInterface {
  /// Constructs a AppsPlatform.
  AppsPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppsPlatform _instance = MethodChannelApps();

  /// The default instance of [AppsPlatform] to use.
  ///
  /// Defaults to [MethodChannelApps].
  static AppsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppsPlatform] when
  /// they register themselves.
  static set instance(AppsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

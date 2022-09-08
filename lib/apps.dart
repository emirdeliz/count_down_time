
import 'apps_platform_interface.dart';

class Apps {
  Future<String?> getPlatformVersion() {
    return AppsPlatform.instance.getPlatformVersion();
  }
}

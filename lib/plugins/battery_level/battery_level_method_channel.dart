import 'package:experiments/plugins/battery_level/bettery_level_interface.dart';
import 'package:flutter/services.dart';

class BatteryPluginMethodImplementation implements IBatteryPlugin {
  // [...]

  @override
  Future<num?> getBatteryLevel() async {
    const methodChannel = MethodChannel('com.experiments/BatteryPlugin');
    try {
      return await methodChannel.invokeMethod<num?>('getBatteryLevel');
    } on PlatformException catch (_) {
      return null;
    }
  }
}

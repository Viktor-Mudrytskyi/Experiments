abstract interface class IBatteryPlugin {
  // [...]

  Future<num?> getBatteryLevel();
}

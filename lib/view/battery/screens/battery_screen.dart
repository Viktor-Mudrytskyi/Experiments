import 'package:experiments/plugins/plugins.dart';
import 'package:flutter/material.dart';

class BatteryScreen extends StatefulWidget {
  const BatteryScreen({super.key});

  @override
  State<BatteryScreen> createState() => _BatteryScreenState();
}

class _BatteryScreenState extends State<BatteryScreen> {
  final BatteryPluginMethodImplementation _batteryPlugin = BatteryPluginMethodImplementation();

  String _batteryLevel = '';

  @override
  void initState() {
    _batteryPlugin.getBatteryLevel().then(
          (res) => setState(() {
            _batteryLevel = res.toString();
          }),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Battery level: $_batteryLevel',
        style: const TextStyle(fontSize: 26),
      ),
    );
  }
}

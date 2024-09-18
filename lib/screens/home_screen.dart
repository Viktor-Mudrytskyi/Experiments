import 'package:experiments/plugins/battery_level/battery_level_method_channel.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Battery level: $_batteryLevel',
                style: const TextStyle(fontSize: 26),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

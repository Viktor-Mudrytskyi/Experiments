import 'package:experiments/core/core.dart';
import 'package:experiments/view/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      color: Colors.lightBlue,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue)),
    );
  }
}

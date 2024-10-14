import 'package:experiments/view/view.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = _defaultIndex;

  static const _defaultIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LazyLoadIndexedStack(
          index: _index,
          children: const [
            BatteryScreen(),
            RxScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.battery_full),
            label: 'Battery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.r_mobiledata_outlined),
            label: 'RxDart',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

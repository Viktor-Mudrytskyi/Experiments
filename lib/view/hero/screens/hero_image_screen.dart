import 'package:experiments/view/view.dart';
import 'package:flutter/material.dart';

class HeroImageScreen extends StatelessWidget {
  const HeroImageScreen({super.key, required this.heroTag});
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.orangeAccent,
      child: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Hero(
              transitionOnUserGestures: true,
              tag: heroTag,
              child: const ImageWidget(asset: 'assets/images/fight_club.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}

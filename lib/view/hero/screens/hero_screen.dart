import 'package:experiments/view/view.dart';
import 'package:flutter/material.dart';

class HeroScreen extends StatelessWidget {
  const HeroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        final heroTag = 'fight-club$index';
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => HeroImageScreen(
                  heroTag: heroTag,
                ),
              ),
            );
          },
          child: Hero(
            tag: heroTag,
            transitionOnUserGestures: true,
            flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
              return FadeTransition(
                opacity: animation,
                child: const ImageWidget(
                  asset: 'assets/images/fight_club.jpg',
                ),
              );
            },
            placeholderBuilder: (context, heroSize, child) {
              return const ImageWidget(
                asset: 'assets/images/fight_club.jpg',
              );
            },
            child: const ImageWidget(
              asset: 'assets/images/fight_club.jpg',
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key, required this.asset});
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Image.asset(asset);
  }
}

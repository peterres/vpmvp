import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class FadedEdgeImage extends StatelessWidget {
  final String imagePath;
  final double size;

  FadedEdgeImage({required this.imagePath, this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Opacity(
            opacity: 0.9,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

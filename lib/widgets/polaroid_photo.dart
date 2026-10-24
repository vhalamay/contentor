import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../polaroid_dimensions.dart';

class PolaroidPhoto extends StatelessWidget {
  const PolaroidPhoto({super.key, required this.image, required this.sigma});

  final ui.Image image;
  final double sigma;

  @override
  Widget build(BuildContext context) {
    final scale = polaroidImageRect.width / math.min(image.width, image.height);
    return ClipRect(
      child: ImageFiltered(
        enabled: sigma > 0,
        imageFilter: ui.ImageFilter.blur(
          sigmaX: sigma * scale,
          sigmaY: sigma * scale,
          tileMode: ui.TileMode.clamp,
        ),
        child: RawImage(image: image, fit: BoxFit.cover, alignment: Alignment.center),
      ),
    );
  }
}

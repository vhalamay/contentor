import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../dialogue/dialogue_controller.dart';
import '../dialogue/dialogue_renderer.dart';
import '../dialogue/grid_settings.dart';
import '../polaroid_dimensions.dart';
import '../polaroid_caption.dart';
import 'image_preview_painter.dart';
import 'polaroid_photo.dart';

class DialogueCanvas extends StatelessWidget {
  const DialogueCanvas({
    super.key, required this.image, required this.sigma,
    required this.controller, required this.enabled,
    required this.caption,
  });

  final ui.Image image;
  final double sigma;
  final DialogueController controller;
  final bool enabled;
  final CaptionSettings caption;

  void _handleTap(TapUpDetails details) {
    final point = details.localPosition;
    if (!polaroidImageRect.contains(point)) return;
    if (controller.selected == null) {
      controller.select(hitDialogue(point, controller.items));
    } else {
      controller.position(
        ((point.dy - polaroidImageRect.top) / polaroidImageRect.height * gridSize).floor(),
        ((point.dx - polaroidImageRect.left) / polaroidImageRect.width * gridSize).floor(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: SizedBox(
        width: polaroidWidth.toDouble(),
        height: polaroidHeightFor(caption).toDouble(),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapUp: enabled ? _handleTap : null,
          child: ColoredBox(
            color: Colors.white,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fromRect(
                  rect: polaroidImageRect,
                  child: PolaroidPhoto(image: image, sigma: sigma),
                ),
                CustomPaint(
                  painter: ImagePreviewPainter(
                    dialogues: controller.items, selected: controller.selected,
                    caption: caption,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

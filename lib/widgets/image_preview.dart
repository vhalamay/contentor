import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../polaroid_layout.dart';
import '../polaroid_caption.dart';
import '../dialogue/dialogue_controller.dart';
import 'dialogue_canvas.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key, required this.image, required this.sigma,
    required this.dialogues, required this.enabled,
    required this.caption,
  });

  final ui.Image? image;
  final double sigma;
  final DialogueController dialogues;
  final bool enabled;
  final CaptionSettings caption;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: polaroidWidth / polaroidHeightFor(caption),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Padding(
          padding: image == null ? const EdgeInsets.all(16) : EdgeInsets.zero,
          child: image == null
              ? const _Placeholder()
              : Semantics(
                  image: true,
                  label: 'Selected image Polaroid preview',
                  child: ClipRect(
                    child: DialogueCanvas(
                      image: image!, sigma: sigma,
                      controller: dialogues, enabled: enabled,
                      caption: caption,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          const Text('Your image will appear here', textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../dialogue/dialogue.dart';
import '../dialogue/dialogue_renderer.dart';
import '../dialogue/grid_renderer.dart';
import '../polaroid_caption.dart';
import '../polaroid_photo_border.dart';

class ImagePreviewPainter extends CustomPainter {
  const ImagePreviewPainter({
    this.dialogues = const [], this.selected,
    this.caption = const CaptionSettings(),
  });

  final List<Dialogue> dialogues;
  final Dialogue? selected;
  final CaptionSettings caption;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    paintDialogues(canvas, dialogues);
    if (selected != null) paintGrid(canvas, selected!);
    paintPolaroidPhotoBorder(canvas);
    paintPolaroidCaption(canvas, caption);
    canvas.restore();
  }

  @override
  bool shouldRepaint(ImagePreviewPainter oldDelegate) =>
      oldDelegate.dialogues != dialogues || oldDelegate.selected != selected ||
      oldDelegate.caption != caption;
}

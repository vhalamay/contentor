import 'dart:ui' as ui;

import 'image_effects.dart';
import 'dialogue/dialogue.dart';
import 'dialogue/dialogue_renderer.dart';
import 'polaroid_dimensions.dart';
import 'polaroid_caption.dart';
import 'polaroid_photo_border.dart';

export 'polaroid_dimensions.dart';

void paintPolaroid(ui.Canvas canvas, ui.Image image, double sigma, {
  List<Dialogue> dialogues = const [],
  CaptionSettings caption = const CaptionSettings(),
}) {
  canvas.drawRect(
    ui.Rect.fromLTWH(
      0, 0, polaroidWidth.toDouble(), polaroidHeightFor(caption).toDouble(),
    ),
    ui.Paint()..color = const ui.Color(0xFFFFFFFF),
  );
  paintProcessedImage(canvas, image, sigma, destination: polaroidImageRect);
  paintDialogues(canvas, dialogues);
  paintPolaroidPhotoBorder(canvas);
  paintPolaroidCaption(canvas, caption);
}

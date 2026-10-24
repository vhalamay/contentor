import 'dart:ui' as ui;

import 'polaroid_dimensions.dart';

void paintPolaroidPhotoBorder(ui.Canvas canvas) {
  canvas.drawRect(
    polaroidImageRect.deflate(0.5),
    ui.Paint()
      ..color = const ui.Color(0xFF000000)
      ..style = ui.PaintingStyle.stroke
      ..strokeWidth = 1,
  );
}

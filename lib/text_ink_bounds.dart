import 'dart:ui' as ui;

import 'package:flutter/painting.dart';

Future<ui.Rect?> measureTextInkBounds(TextPainter painter) async {
  const margin = 64.0;
  final recorder = ui.PictureRecorder();
  painter.paint(ui.Canvas(recorder), const ui.Offset(margin, margin));
  final picture = recorder.endRecording();
  ui.Image? raster;
  try {
    final width = (painter.width + margin * 2).ceil();
    final height = (painter.height + margin * 2).ceil();
    if (height > 8192) return null;
    raster = await picture.toImage(width, height);
    final data = await raster.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (data == null) return null;
    var left = width, top = height, right = -1, bottom = -1;
    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        if (data.getUint8((y * width + x) * 4 + 3) == 0) continue;
        if (x < left) left = x;
        if (x > right) right = x;
        if (y < top) top = y;
        if (y > bottom) bottom = y;
      }
    }
    if (right < left) return null;
    return ui.Rect.fromLTRB(
      left - margin, top - margin, right + 1 - margin, bottom + 1 - margin,
    );
  } finally {
    raster?.dispose();
    picture.dispose();
  }
}

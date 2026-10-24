import 'dart:math' as math;
import 'dart:ui' as ui;

void paintProcessedImage(ui.Canvas canvas, ui.Image image, double sigma, {
  required ui.Rect destination,
}) {
  final side = math.min(image.width, image.height).toDouble();
  final source = ui.Rect.fromLTWH(
    (image.width - side) / 2, (image.height - side) / 2, side, side,
  );
  final scale = destination.width / side;
  final paint = ui.Paint()..filterQuality = ui.FilterQuality.medium;
  if (sigma > 0) {
    paint.imageFilter = ui.ImageFilter.blur(
      sigmaX: sigma * scale,
      sigmaY: sigma * scale,
      tileMode: ui.TileMode.clamp,
    );
  }
  canvas.save();
  canvas.clipRect(destination);
  canvas.drawImageRect(image, source, destination, paint);
  canvas.restore();
}

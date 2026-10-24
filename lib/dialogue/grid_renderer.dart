import 'package:flutter/material.dart';

import '../polaroid_dimensions.dart';
import 'dialogue.dart';
import 'grid_settings.dart';

void paintGrid(Canvas canvas, Dialogue selected) {
  final area = polaroidImageRect;
  canvas.save();
  canvas.clipRect(area);
  final cell = area.width / gridSize;
  final selectedRect = Rect.fromLTWH(
    area.left + selected.column * cell,
    area.top + selected.row * cell,
    cell, cell,
  );
  canvas.drawRect(selectedRect, Paint()..color = const Color(0x336254C7));
  final line = Paint()
    ..color = const Color(0xCCFFFFFF)
    ..strokeWidth = 2;
  final dark = Paint()
    ..color = const Color(0x88000000)
    ..strokeWidth = 4;
  for (var i = 0; i <= gridSize; i++) {
    final x = area.left + i * cell;
    final y = area.top + i * cell;
    for (final paint in [dark, line]) {
      canvas.drawLine(Offset(x, area.top), Offset(x, area.bottom), paint);
      canvas.drawLine(Offset(area.left, y), Offset(area.right, y), paint);
    }
  }
  canvas.drawRect(selectedRect, Paint()
    ..color = const Color(0xFFB7A9FF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5);
  canvas.drawCircle(selectedRect.center, 7, Paint()..color = Colors.white);
  canvas.restore();
}

import 'package:flutter/painting.dart';

import '../polaroid_dimensions.dart';
import 'dialogue.dart';
import 'dialogue_bubble.dart';
import 'dialogue_appearance.dart';
import 'watermark_appearance.dart';

TextPainter layoutDialogue(Dialogue item) => TextPainter(
  text: TextSpan(
    text: item.text,
    style: item.isHandle ? watermarkTextStyle : dialogueTextStyle,
  ),
  textAlign: dialogueTextAlignment,
  textDirection: TextDirection.ltr,
  locale: const Locale('uk'),
  textScaler: TextScaler.noScaling,
)..layout(maxWidth: polaroidImageRect.width * dialogueMaxWidthFraction);

Offset dialogueOrigin(Dialogue item, TextPainter painter) {
  final bounds = dialogueTextBounds(item, painter);
  final origin = Offset(
    polaroidImageRect.left + item.center.dx * polaroidImageRect.width - bounds.center.dx,
    polaroidImageRect.top + item.center.dy * polaroidImageRect.height - bounds.center.dy,
  );
  if (!item.isHandle) return origin;
  // Keep the fixed handle fully readable even in a cell along an image edge.
  final area = polaroidImageRect.deflate(watermarkInset);
  return Offset(
    origin.dx.clamp(area.left, area.right - painter.width).toDouble(),
    origin.dy.clamp(area.top, area.bottom - painter.height).toDouble(),
  );
}

Rect dialogueTextBounds(Dialogue item, TextPainter painter) =>
    item.inkBounds ?? (Offset.zero & painter.size);

void paintDialogues(Canvas canvas, List<Dialogue> items) {
  canvas.save();
  canvas.clipRect(polaroidImageRect);
  for (final item in items) {
    final painter = layoutDialogue(item);
    try {
      final origin = dialogueOrigin(item, painter);
      if (!item.isHandle) {
        final bounds = dialogueTextBounds(item, painter).shift(origin);
        paintDialogueBubble(canvas, dialogueBubbleBounds(bounds.topLeft, bounds.size));
      }
      painter.paint(canvas, origin);
    } finally {
      painter.dispose();
    }
  }
  canvas.restore();
}

String? hitDialogue(Offset point, List<Dialogue> items) {
  if (!polaroidImageRect.contains(point)) return null;
  for (final item in items.reversed) {
    final painter = layoutDialogue(item);
    try {
      final origin = dialogueOrigin(item, painter);
      final hit = item.isHandle
          ? (origin & painter.size).inflate(8).contains(point)
          : dialogueBubbleBounds(
              dialogueTextBounds(item, painter).shift(origin).topLeft,
              dialogueTextBounds(item, painter).size,
            ).contains(point);
      if (hit) {
        return item.id;
      }
    } finally {
      painter.dispose();
    }
  }
  return null;
}

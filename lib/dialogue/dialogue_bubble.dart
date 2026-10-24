import 'package:flutter/painting.dart';

import 'dialogue_appearance.dart';

RRect dialogueBubbleBounds(Offset origin, Size textSize) =>
    RRect.fromRectAndRadius(
      Rect.fromLTWH(
        origin.dx - dialogueBubblePaddingHorizontal,
        origin.dy - dialogueBubblePaddingVertical,
        textSize.width + dialogueBubblePaddingHorizontal * 2,
        textSize.height + dialogueBubblePaddingVertical * 2,
      ),
      const Radius.circular(dialogueBubbleRadius),
    );

void paintDialogueBubble(Canvas canvas, RRect bounds) {
  canvas.drawRRect(bounds, Paint()..color = dialogueBubbleColor);
}

import 'package:flutter/painting.dart';

import 'polaroid_dimensions.dart';
import 'caption_settings.dart';

export 'caption_settings.dart';

const polaroidCaptionStyle = TextStyle(
  fontFamily: 'NotoSans',
  fontSize: defaultCaptionFontSize,
  fontWeight: FontWeight.w500,
  fontVariations: [FontVariation('wght', 500)],
  letterSpacing: 1.5,
  color: Color(0xFF24242A),
);

TextPainter layoutPolaroidCaption(CaptionSettings caption) => TextPainter(
    text: TextSpan(
      text: caption.text.trim(),
      style: polaroidCaptionStyle.copyWith(fontSize: caption.fontSize),
    ),
    textAlign: caption.alignment == CaptionAlignment.center
        ? TextAlign.center : TextAlign.left,
    textDirection: TextDirection.ltr,
    textScaler: TextScaler.noScaling,
  )..layout(maxWidth: polaroidImageRect.width);

int polaroidHeightFor(CaptionSettings caption) {
  if (caption.text.trim().isEmpty) {
    return (polaroidImageRect.bottom + polaroidTopBorder).ceil();
  }
  final painter = layoutPolaroidCaption(caption);
  try {
    final height = caption.inkBounds?.height ?? painter.height;
    return (polaroidImageRect.bottom + polaroidTopBorder * 2 + height).ceil();
  } finally {
    painter.dispose();
  }
}

void paintPolaroidCaption(Canvas canvas, CaptionSettings caption) {
  if (caption.text.trim().isEmpty) return;
  final painter = layoutPolaroidCaption(caption);
  final bounds = caption.inkBounds ?? (Offset.zero & painter.size);
  final footer = Rect.fromLTRB(
    polaroidImageRect.left, polaroidImageRect.bottom,
    polaroidImageRect.right, polaroidHeightFor(caption).toDouble(),
  );
  try {
    canvas.save();
    canvas.clipRect(footer);
    painter.paint(canvas, Offset(
      caption.alignment == CaptionAlignment.center
          ? footer.center.dx - bounds.center.dx : footer.left - bounds.left,
      footer.top + polaroidTopBorder - bounds.top,
    ));
    canvas.restore();
  } finally {
    painter.dispose();
  }
}

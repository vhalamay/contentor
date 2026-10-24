import 'dart:ui' show Rect;

const double defaultCaptionFontSize = 72;
const captionFontSizes = <double>[60, 72, 84];

enum CaptionAlignment { left, center }

class CaptionSettings {
  const CaptionSettings({
    this.text = '',
    this.fontSize = defaultCaptionFontSize,
    this.alignment = CaptionAlignment.left,
    this.inkBounds,
  });

  final String text;
  final double fontSize;
  final CaptionAlignment alignment;
  final Rect? inkBounds;

  CaptionSettings copyWith({
    String? text, double? fontSize, CaptionAlignment? alignment,
    Rect? inkBounds,
  }) => CaptionSettings(
    text: text ?? this.text,
    fontSize: fontSize ?? this.fontSize,
    alignment: alignment ?? this.alignment,
    inkBounds: inkBounds ?? (
      (text == null || text == this.text) &&
      (fontSize == null || fontSize == this.fontSize) &&
      (alignment == null || alignment == this.alignment) ? this.inkBounds : null
    ),
  );
}

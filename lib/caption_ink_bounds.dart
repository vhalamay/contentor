import 'caption_settings.dart';
import 'polaroid_caption.dart';
import 'text_ink_bounds.dart';

Future<CaptionSettings> measureCaptionInk(CaptionSettings caption) async {
  if (caption.text.trim().isEmpty || caption.inkBounds != null) return caption;
  final painter = layoutPolaroidCaption(caption);
  try {
    final bounds = await measureTextInkBounds(painter);
    return bounds == null ? caption : caption.copyWith(inkBounds: bounds);
  } finally {
    painter.dispose();
  }
}

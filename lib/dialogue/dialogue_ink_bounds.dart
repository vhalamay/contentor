import '../text_ink_bounds.dart';
import 'dialogue.dart';
import 'dialogue_renderer.dart';

Future<Dialogue> measureDialogueInk(Dialogue item) async {
  if (item.isHandle || item.inkBounds != null) return item;
  final painter = layoutDialogue(item);
  try {
    final bounds = await measureTextInkBounds(painter);
    return bounds == null ? item : item.copyWith(inkBounds: bounds);
  } finally {
    painter.dispose();
  }
}

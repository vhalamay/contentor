import 'dart:ui' show Offset, Rect;

import 'grid_settings.dart';

const handleDialogueId = 'polaroid-handle';
const handleDialogueText = '@beaverly.hills.ua';

class Dialogue {
  Dialogue({
    required this.id,
    required String text,
    required this.row,
    required this.column,
    this.inkBounds,
  }) : text = id == handleDialogueId ? handleDialogueText : text,
       center = Offset((column + 0.5) / gridSize, (row + 0.5) / gridSize);

  final String id;
  final String text;
  final int row;
  final int column;
  final Offset center;
  final Rect? inkBounds;
  bool get isHandle => id == handleDialogueId;

  Dialogue copyWith({
    String? text,
    int? row,
    int? column,
    Rect? inkBounds,
  }) => Dialogue(
    id: id,
    text: text ?? this.text,
    row: row ?? this.row,
    column: column ?? this.column,
    inkBounds: inkBounds ?? (text == null || text == this.text ? this.inkBounds : null),
  );
}

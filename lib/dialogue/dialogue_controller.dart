import 'package:flutter/foundation.dart';

import 'dialogue.dart';
import 'dialogue_ink_bounds.dart';
import 'grid_settings.dart';

class DialogueController extends ChangeNotifier {
  List<Dialogue> _items = [
    Dialogue(id: handleDialogueId, text: handleDialogueText, row: 0, column: 0),
  ];
  String? _selectedId;
  int _nextId = 0;
  bool _disposed = false;

  List<Dialogue> get items => List.unmodifiable(_items);
  Dialogue? get selected {
    for (final item in _items) {
      if (item.id == _selectedId) return item;
    }
    return null;
  }

  void add() {
    final item = Dialogue(
      id: 'dialogue-${_nextId++}',
      text: 'Новий діалог',
      row: gridSize ~/ 2,
      column: gridSize ~/ 2,
    );
    _items = [..._items, item];
    _selectedId = item.id;
    notifyListeners();
    _measure(item);
  }

  void select(String? id) {
    _selectedId = id;
    notifyListeners();
    final item = selected;
    if (item != null) _measure(item);
  }

  void update(Dialogue item) {
    _items = [for (final current in _items) current.id == item.id ? item : current];
    notifyListeners();
    _measure(item);
  }

  Future<void> _measure(Dialogue item) async {
    if (item.isHandle || item.inkBounds != null) return;
    try {
      final measured = await measureDialogueInk(item);
      if (_disposed || !_items.any((current) => identical(current, item))) return;
      _items = [for (final current in _items) identical(current, item) ? measured : current];
      notifyListeners();
    } catch (_) {
      // Preserve editable text if the graphics backend cannot measure it.
    }
  }

  void position(int row, int column) {
    final item = selected;
    if (item == null) return;
    update(item.copyWith(
      row: row.clamp(0, gridSize - 1).toInt(),
      column: column.clamp(0, gridSize - 1).toInt(),
    ));
  }

  void delete(String id) {
    if (id == handleDialogueId) return;
    _items = _items.where((item) => item.id != id).toList();
    if (_selectedId == id) _selectedId = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

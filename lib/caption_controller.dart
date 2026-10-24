import 'package:flutter/foundation.dart';

import 'caption_ink_bounds.dart';
import 'caption_settings.dart';

export 'caption_settings.dart';

class CaptionController extends ChangeNotifier {
  CaptionSettings value = const CaptionSettings();
  bool _disposed = false;

  Future<void> update(CaptionSettings next, {required bool enabled}) async {
    if (!enabled || _disposed) return;
    value = next;
    notifyListeners();
    try {
      final measured = await measureCaptionInk(next);
      if (_disposed || !identical(value, next)) return;
      value = measured;
      notifyListeners();
    } catch (_) {
      // Keep the caption editable if raster measurement is unavailable.
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}

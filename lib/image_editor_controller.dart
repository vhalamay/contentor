import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import 'blur_settings.dart';
import 'caption_controller.dart';
import 'dialogue/dialogue.dart';
import 'image_export.dart';
import 'image_processing.dart';
import 'image_selection.dart';

class ImageEditorController extends ChangeNotifier {
  ImageEditorController({required this.selectImage}) {
    captionEditor.addListener(notifyListeners);
  }

  final Future<PickedImage?> Function() selectImage;
  SelectedImage? image;
  bool isLoading = false;
  bool isExporting = false;
  double blurIntensity = 0;
  final CaptionController captionEditor = CaptionController();
  bool _disposed = false;

  bool get isBusy => isLoading || isExporting;
  double get sigma => blurIntensity;
  CaptionSettings get caption => captionEditor.value;

  Future<void> setCaption(CaptionSettings value) => captionEditor.update(value, enabled: !isBusy);

  void setBlurIntensity(double value) {
    if (isBusy || image == null) return;
    blurIntensity = value.clamp(0, maxBlurIntensity).toDouble();
    notifyListeners();
  }

  Future<String?> chooseImage() async {
    if (isBusy || _disposed) return null;
    isLoading = true;
    notifyListeners();
    try {
      final source = await selectImage();
      if (_disposed || source == null) return null;
      final selected = await decodeSelectedImage(
        source.bytes,
        originalName: source.name,
      );
      if (_disposed) {
        selected.dispose();
        return null;
      }
      final previous = image;
      image = selected;
      previous?.dispose();
      return null;
    } catch (error) {
      return error is FormatException
          ? error.message
          : 'Could not load this image. Please try another file.';
    } finally {
      isLoading = false;
      if (!_disposed) notifyListeners();
    }
  }

  Future<String?> exportImage({List<Dialogue> dialogues = const []}) async {
    final selected = image;
    if (isBusy || selected == null || _disposed) return null;
    final selectedSigma = sigma;
    final selectedCaption = caption;
    isExporting = true;
    notifyListeners();
    try {
      await SchedulerBinding.instance.endOfFrame;
      if (_disposed) return null;
      final saved = await exportPng(
        selected.image,
        selectedSigma,
        originalName: selected.originalName,
        dialogues: List.unmodifiable(dialogues),
        caption: selectedCaption,
      );
      return saved ? 'PNG saved successfully.' : 'Export cancelled.';
    } catch (_) {
      return 'Could not export PNG. Try again or choose a smaller image.';
    } finally {
      isExporting = false;
      if (!_disposed) notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    captionEditor.removeListener(notifyListeners);
    captionEditor.dispose();
    image?.dispose();
    super.dispose();
  }
}

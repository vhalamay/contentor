import 'dart:typed_data';
import 'dart:ui' as ui;

import 'polaroid_layout.dart';
import 'polaroid_caption.dart';
import 'caption_ink_bounds.dart';
import 'dialogue/dialogue.dart';
import 'dialogue/dialogue_ink_bounds.dart';

class SelectedImage {
  const SelectedImage({
    required this.originalBytes,
    required this.originalName,
    required this.image,
  });

  final Uint8List originalBytes;
  final String originalName;
  final ui.Image image;

  void dispose() => image.dispose();
}

Future<SelectedImage> decodeSelectedImage(
  Uint8List bytes, {
  required String originalName,
}) async {
  final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
  ui.ImageDescriptor? descriptor;
  ui.Codec? codec;
  try {
    descriptor = await ui.ImageDescriptor.encoded(buffer);
    // Reject oversized files before allocating a full-resolution raster. Never
    // silently downsample an image that will later be exported.
    if (descriptor.width > 8192 ||
        descriptor.height > 8192 ||
        descriptor.width * descriptor.height > 25000000) {
      throw const FormatException(
        'This image is too large. Choose one up to 25 megapixels '
        'and 8192 pixels per side.',
      );
    }
    codec = await descriptor.instantiateCodec();
    final frame = await codec.getNextFrame();
    return SelectedImage(
      originalBytes: bytes,
      originalName: originalName,
      image: frame.image,
    );
  } finally {
    codec?.dispose();
    descriptor?.dispose();
    buffer.dispose();
  }
}

Future<Uint8List> encodePng(ui.Image image, double sigma, {
  List<Dialogue> dialogues = const [],
  CaptionSettings caption = const CaptionSettings(),
}) async {
  final measuredDialogues = await Future.wait(dialogues.map(measureDialogueInk));
  final measuredCaption = await measureCaptionInk(caption);
  final recorder = ui.PictureRecorder();
  final canvas = ui.Canvas(recorder);
  paintPolaroid(canvas, image, sigma, dialogues: measuredDialogues, caption: measuredCaption);
  final picture = recorder.endRecording();
  ui.Image? output;
  try {
    output = await picture.toImage(polaroidWidth, polaroidHeightFor(measuredCaption));
    final data = await output.toByteData(format: ui.ImageByteFormat.png);
    if (data == null) throw StateError('Could not encode PNG.');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  } finally {
    output?.dispose();
    picture.dispose();
  }
}

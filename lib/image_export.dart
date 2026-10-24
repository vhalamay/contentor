import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';

import 'export_filename.dart';
import 'caption_settings.dart';
import 'dialogue/dialogue.dart';
import 'image_processing.dart';

Future<bool> exportPng(
  ui.Image image,
  double sigma, {
  required String originalName,
  List<Dialogue> dialogues = const [],
  CaptionSettings caption = const CaptionSettings(),
}) async {
  final fileName = buildExportFileName(originalName, DateTime.now());
  // Own a handle while encoding so closing the screen cannot dispose the
  // underlying image during an asynchronous render.
  final snapshot = image.clone();
  try {
    final bytes = await encodePng(snapshot, sigma, dialogues: dialogues, caption: caption);
    final destination = await FilePicker.saveFile(
      fileName: fileName,
      bytes: bytes,
      mimeType: 'image/png',
      dialogTitle: 'Export PNG',
      type: FileType.custom,
      allowedExtensions: ['png'],
    );
    return destination != null;
  } finally {
    snapshot.dispose();
  }
}

import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

const imageExtensions = ['png', 'jpg', 'jpeg', 'webp'];

typedef PickedImage = ({Uint8List bytes, String name});

Future<PickedImage?> chooseImage() async {
  final file = await FilePicker.pickFile(
    dialogTitle: 'Choose Image',
    type: FileType.custom,
    allowedExtensions: imageExtensions,
  );
  if (file == null) return null;

  if (!imageExtensions.contains(file.extension?.toLowerCase())) {
    throw const FormatException('Unsupported image format.');
  }
  final bytes = await file.readAsBytes();
  if (bytes.isEmpty) throw const FormatException('The image is empty.');

  return (bytes: bytes, name: file.name);
}

import 'package:flutter/material.dart';

import 'image_editor_controller.dart';
import 'dialogue/dialogue_controller.dart';
import 'image_selection.dart';
import 'widgets/image_editor_layout.dart';

class ImagePreviewScreen extends StatefulWidget {
  const ImagePreviewScreen({super.key, this.selectImage = chooseImage});

  final Future<PickedImage?> Function() selectImage;

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  late final ImageEditorController _controller;
  final DialogueController _dialogues = DialogueController();

  @override
  void initState() {
    super.initState();
    _controller = ImageEditorController(
      selectImage: () => widget.selectImage(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _dialogues.dispose();
    super.dispose();
  }

  Future<void> _perform(Future<String?> Function() action) async {
    final message = await action();
    if (!mounted || message == null) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contentor')),
      body: SafeArea(
        child: ListenableBuilder(
          listenable: Listenable.merge([_controller, _dialogues]),
          builder: (context, child) => ImageEditorLayout(
            controller: _controller,
            dialogues: _dialogues,
            onChoose: () => _perform(_controller.chooseImage),
            onExport: () => _perform(
              () => _controller.exportImage(dialogues: _dialogues.items),
            ),
          ),
        ),
      ),
    );
  }
}

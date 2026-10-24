import 'package:flutter/material.dart';

import '../dialogue/dialogue_controller.dart';
import '../image_editor_controller.dart';
import 'editor_settings_pane.dart';
import 'image_editor_content.dart';
import 'image_preview.dart';

class ImageEditorLayout extends StatelessWidget {
  const ImageEditorLayout({
    super.key, required this.controller, required this.dialogues,
    required this.onChoose, required this.onExport,
  });

  final ImageEditorController controller;
  final DialogueController dialogues;
  final VoidCallback onChoose;
  final VoidCallback onExport;

  @override
  Widget build(BuildContext context) {
    final vertical = MediaQuery.orientationOf(context) == Orientation.portrait;
    return Flex(
      direction: vertical ? Axis.vertical : Axis.horizontal,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ImagePreview(
                image: controller.image?.image,
                sigma: controller.sigma,
                caption: controller.caption,
                dialogues: dialogues,
                enabled: controller.image != null && !controller.isBusy,
              ),
            ),
          ),
        ),
        Expanded(
          child: EditorSettingsPane(
            vertical: vertical,
            child: ImageEditorContent(
              controller: controller, dialogues: dialogues,
              onChoose: onChoose, onExport: onExport,
            ),
          ),
        ),
      ],
    );
  }
}

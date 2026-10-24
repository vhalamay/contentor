import 'package:flutter/material.dart';

import '../image_editor_controller.dart';
import '../polaroid_caption.dart';
import '../dialogue/dialogue_controller.dart';
import '../dialogue/dialogue_panel.dart';
import 'blur_controls.dart';
import 'caption_controls.dart';
import 'image_action_button.dart';

class ImageEditorContent extends StatelessWidget {
  const ImageEditorContent({
    super.key,
    required this.controller,
    required this.dialogues,
    required this.onChoose,
    required this.onExport,
  });

  final ImageEditorController controller;
  final DialogueController dialogues;
  final VoidCallback onChoose;
  final VoidCallback onExport;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage = controller.image != null;
    final canEdit = hasImage && !controller.isBusy;
    final hintStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ImageActionButton(
          label: 'Choose Image',
          busyLabel: 'Opening image…',
          icon: Icons.photo_library_outlined,
          isBusy: controller.isLoading,
          onPressed: controller.isBusy ? null : onChoose,
        ),
        const SizedBox(height: 12),
        Text(
          'PNG, JPG, JPEG or WebP${hasImage ? ' • Choose another image to replace it' : ''}',
          textAlign: TextAlign.center,
          style: hintStyle,
        ),
        const SizedBox(height: 24),
        BlurControls(
          intensity: controller.blurIntensity,
          onChanged: canEdit ? controller.setBlurIntensity : null,
        ),
        DialoguePanel(controller: dialogues, enabled: canEdit),
        const SizedBox(height: 16),
        CaptionControls(
          value: controller.caption,
          enabled: !controller.isBusy,
          onChanged: controller.setCaption,
        ),
        const SizedBox(height: 16),
        ImageActionButton(
          label: 'Export PNG',
          busyLabel: 'Exporting…',
          icon: Icons.download_outlined,
          isBusy: controller.isExporting,
          onPressed: canEdit ? onExport : null,
        ),
        const SizedBox(height: 12),
        Text(
          'Polaroid PNG • 1080 × ${polaroidHeightFor(controller.caption)} px',
          textAlign: TextAlign.center,
          style: hintStyle,
        ),
      ],
    );
  }
}

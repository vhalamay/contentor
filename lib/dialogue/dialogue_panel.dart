import 'package:flutter/material.dart';

import 'dialogue_controller.dart';
import 'dialogue_editor.dart';

class DialoguePanel extends StatelessWidget {
  const DialoguePanel({super.key, required this.controller, required this.enabled});

  final DialogueController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final selected = controller.selected;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: enabled ? controller.add : null,
          icon: const Icon(Icons.add_comment_outlined),
          label: const Text('Add Dialogue'),
        ),
        if (controller.items.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(spacing: 8, runSpacing: 8, children: [
            for (final item in controller.items)
              InputChip(
                label: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Text(
                    '${item.row + 1}×${item.column + 1} · '
                    '${item.text.isEmpty ? 'Empty dialogue' : item.text}',
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                selected: selected?.id == item.id,
                onSelected: enabled ? (_) => controller.select(item.id) : null,
                onDeleted: enabled && !item.isHandle
                    ? () => controller.delete(item.id) : null,
              ),
          ]),
        ],
        if (selected != null) ...[
          const SizedBox(height: 12),
          const Text('Tap a grid cell on the image to position this dialogue.'),
          const SizedBox(height: 12),
          if (!selected.isHandle) ExcludeFocus(
            excluding: !enabled,
            child: IgnorePointer(
              ignoring: !enabled,
              child: DialogueEditor(
                key: ValueKey(selected.id),
                item: selected, onChanged: controller.update,
              ),
            ),
          ),
          TextButton(
            onPressed: enabled ? () => controller.select(null) : null,
            child: const Text('Done editing'),
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../caption_settings.dart';

class CaptionControls extends StatelessWidget {
  const CaptionControls({
    super.key, required this.value, required this.enabled, required this.onChanged,
  });

  final CaptionSettings value;
  final bool enabled;
  final ValueChanged<CaptionSettings> onChanged;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      TextFormField(
        initialValue: value.text,
        enabled: enabled,
        minLines: 1,
        maxLines: 4,
        decoration: const InputDecoration(
          labelText: 'Caption', border: OutlineInputBorder(),
        ),
        onChanged: (text) => onChanged(value.copyWith(text: text)),
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8, runSpacing: 8,
        children: [
          for (final size in captionFontSizes)
            ChoiceChip(
              label: Text(size.toInt().toString()),
              selected: value.fontSize == size,
              onSelected: enabled
                  ? (_) => onChanged(value.copyWith(fontSize: size)) : null,
            ),
        ],
      ),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        children: [
          for (final alignment in CaptionAlignment.values)
            ChoiceChip(
              label: Text(alignment == CaptionAlignment.left ? 'Зліва' : 'По центру'),
              avatar: Icon(alignment == CaptionAlignment.left
                  ? Icons.format_align_left : Icons.format_align_center, size: 18),
              selected: value.alignment == alignment,
              onSelected: enabled
                  ? (_) => onChanged(value.copyWith(alignment: alignment)) : null,
            ),
        ],
      ),
    ],
  );
}

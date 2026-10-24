import 'package:flutter/material.dart';

import '../blur_settings.dart';

class BlurControls extends StatelessWidget {
  const BlurControls({
    super.key, required this.intensity, required this.onChanged,
  });

  final double intensity;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    children: [
      for (final preset in blurPresets.entries)
        ChoiceChip(
          label: Text(preset.key),
          selected: intensity == preset.value,
          onSelected: onChanged == null
              ? null
              : (_) => onChanged!(preset.value),
        ),
    ],
  );
}

import 'package:flutter/material.dart';

class EditorSettingsPane extends StatefulWidget {
  const EditorSettingsPane({
    super.key, required this.child, required this.vertical,
  });

  final Widget child;
  final bool vertical;

  @override
  State<EditorSettingsPane> createState() => _EditorSettingsPaneState();
}

class _EditorSettingsPaneState extends State<EditorSettingsPane> {
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final border = BorderSide(color: colors.outlineVariant);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surfaceContainerLow,
        border: widget.vertical ? Border(top: border) : Border(left: border),
      ),
      child: Scrollbar(
        controller: _scroll,
        child: SingleChildScrollView(
          controller: _scroll,
          padding: const EdgeInsets.all(20),
          child: widget.child,
        ),
      ),
    );
  }
}

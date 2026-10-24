import 'package:flutter/material.dart';

import 'dialogue.dart';

class DialogueEditor extends StatefulWidget {
  const DialogueEditor({super.key, required this.item, required this.onChanged});

  final Dialogue item;
  final ValueChanged<Dialogue> onChanged;

  @override
  State<DialogueEditor> createState() => _DialogueEditorState();
}

class _DialogueEditorState extends State<DialogueEditor> {
  late final TextEditingController _text;

  @override
  void initState() {
    super.initState();
    _text = TextEditingController(text: widget.item.text);
  }

  @override
  void didUpdateWidget(DialogueEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_text.text != widget.item.text) _text.text = widget.item.text;
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TextField(
      controller: _text,
      minLines: 2,
      maxLines: 5,
      decoration: const InputDecoration(
        labelText: 'Dialogue text', border: OutlineInputBorder(),
      ),
      onChanged: (value) => widget.onChanged(widget.item.copyWith(text: value)),
    );
}

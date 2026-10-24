import 'package:flutter/material.dart';

class ImageActionButton extends StatelessWidget {
  const ImageActionButton({
    super.key,
    required this.label,
    required this.busyLabel,
    required this.icon,
    required this.isBusy,
    required this.onPressed,
  });

  final String label;
  final String busyLabel;
  final IconData icon;
  final bool isBusy;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      icon: isBusy
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(icon),
      label: Text(isBusy ? busyLabel : label),
    );
  }
}

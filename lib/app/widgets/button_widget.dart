import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  const ButtonWidget({super.key, required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(
        label,
      ),
    );
  }
}

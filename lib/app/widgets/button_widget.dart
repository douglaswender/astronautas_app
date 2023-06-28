import 'package:astronautas_app/app/core/app_colors.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final void Function()? onPressed;
  final bool danger;
  const ButtonWidget(
      {super.key, required this.label, this.onPressed, this.danger = false});

  const ButtonWidget.danger(
      {super.key, required this.label, this.onPressed, this.danger = true});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
          backgroundColor: danger ? AppColors.danger : null),
      onPressed: onPressed,
      child: Text(
        label,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final double? height;
  final Color? buttonColor;
  final double borderRadius;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.title,
    this.height,
    this.buttonColor,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height ?? 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white, // onPrimary
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

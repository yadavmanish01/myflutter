import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final String? hint;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final Color? fillColor;
  final Color? inputColor;
  final void Function()? onTap;
  final bool readOnly;
  final bool isRequired;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? length;
  final int? minLines;
  final int? maxLines;
  final double? inputSize;
  final EdgeInsetsGeometry? contentPadding;
  final bool enableBorder;
  final bool enableShadow;

  const CustomFormField({
    super.key,
    this.hint,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.onSaved,
    this.onTap,
    this.obscureText = false,
    this.fillColor,
    this.inputColor,
    this.controller,
    this.readOnly = false,
    this.isRequired = true,
    this.keyboardType,
    this.length,
    this.minLines = 1,
    this.maxLines = 1,
    this.inputSize,
    this.contentPadding,
    this.enableBorder = true,
    this.enableShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultFill = fillColor ?? Colors.white;

    return Container(
      decoration: enableShadow
          ? BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      )
          : null,
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        minLines: minLines,
        maxLines: maxLines,
        maxLength: length,
        keyboardType: keyboardType,
        onTap: onTap,
        controller: controller,
        readOnly: readOnly,
        style: TextStyle(
          fontSize: inputSize ?? 18,
        ),
        decoration: InputDecoration(
          counterText: "",
          labelText: labelText,
          prefixIcon: prefixIcon,
          fillColor: defaultFill,
          filled: true,
          hintText: hint,
          isDense: true,
          hintStyle: TextStyle(
            fontSize: 16,
          ),
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide( width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: enableBorder
                ? const BorderSide()
                : BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: enableBorder
                ? const BorderSide()
                : BorderSide.none,
          ),
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        obscureText: obscureText,
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}

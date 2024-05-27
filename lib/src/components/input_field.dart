import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    required this.controller,
    this.onbscureText = false,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.inputFormatters,
    this.textAlign,
    this.textStyle,
  });
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool onbscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;
  final TextAlign? textAlign;

  final TextStyle? textStyle;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null && label!.isNotEmpty)
          Text(
            label!,
            style: mediumStyle(12, AppColors.grey29),
          ),
        if (label != null && label!.isNotEmpty) const YMargin(5),
        TextFormField(
          controller: controller,
          style: textStyle ?? mediumStyle(16, AppColors.grey900),
          textAlign: textAlign ?? TextAlign.start,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint ?? label,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
          textCapitalization: TextCapitalization.sentences,
          cursorColor: AppColors.grey900,
          cursorWidth: 1,
          inputFormatters: inputFormatters,
          obscureText: onbscureText,
          obscuringCharacter: "•",
          enabled: enabled,
        ),
      ],
    );
  }
}

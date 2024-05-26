import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';

class BoldHeader extends StatelessWidget {
  const BoldHeader({super.key, required this.text, this.fontSize = 24, this.color});
  final String text;
  final Color? color;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: boldStyle(fontSize, color ?? AppColors.grey900));
  }
}

class LightHeader extends StatelessWidget {
  const LightHeader({super.key, required this.text, this.color, this.fontSize = 16});
  final String text;
  final Color? color;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: mediumStyle(fontSize, color ?? AppColors.grey61),
    );
  }
}

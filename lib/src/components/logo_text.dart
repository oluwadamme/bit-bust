import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  const LogoText({
    super.key,
    this.fontSize = 40,
    this.color,
  });
  final double fontSize;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      "BitBust",
      style: boldStyle(fontSize, color ?? const Color(0xffE6E6E6)),
    );
  }
}

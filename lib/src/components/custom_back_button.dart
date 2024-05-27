import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: SizedBox(
        width: 40,
        height: 40,
        child: SvgPicture.asset("assets/svg/arrow-down.svg", fit: BoxFit.scaleDown),
      ),
    );
  }
}

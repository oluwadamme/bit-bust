import 'package:bitbust/src/components/components.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.asset,
    required this.function,
    this.textColor,
    this.verticalPadding = 10,
  });
  final String title;
  final String subtitle;
  final String asset;
  final Color? textColor;
  final VoidCallback function;
  final double verticalPadding;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: function,
      contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: verticalPadding),
      leading: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(color: AppColors.greyE9, borderRadius: BorderRadius.circular(12)),
        child: SvgPicture.asset(asset, fit: BoxFit.scaleDown),
      ),
      title: BoldHeader(
        text: title,
        fontSize: 14,
        color: textColor ?? AppColors.grey17,
      ),
      subtitle: LightHeader(
        text: subtitle,
        fontSize: 12,
        color: AppColors.grey8B,
      ),
    );
  }
}

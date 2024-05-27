import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';

BottomNavigationBarItem customNavItem(String asset) {
  return BottomNavigationBarItem(
    backgroundColor: Colors.white,
    activeIcon: SizedBox(
      height: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(radius: 4, backgroundColor: AppColors.grey900),
          Helpers.svg(asset, color: AppColors.grey900, fit: BoxFit.scaleDown),
        ],
      ),
    ),
    icon: SizedBox(
      height: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Helpers.svg(asset, fit: BoxFit.scaleDown, color: AppColors.greyeBA),
        ],
      ),
    ),
    label: "",
  );
}

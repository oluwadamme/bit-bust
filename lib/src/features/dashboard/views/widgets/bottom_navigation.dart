import 'package:bitbust/src/features/dashboard/data/controllers/nav_controller.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'custom_nav_item.dart';

class BottomNavigation extends HookConsumerWidget {
  const BottomNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.greye8))),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        currentIndex: ref.watch(dashNavProvider),
        onTap: (value) => ref.read(dashNavProvider.notifier).updatePage(value),
        useLegacyColorScheme: false,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          customNavItem(AppAsset.home),
          customNavItem(AppAsset.wallet),
          customNavItem(AppAsset.gift),
          customNavItem(AppAsset.transaction),
          customNavItem(AppAsset.account),
        ],
      ),
    );
  }
}

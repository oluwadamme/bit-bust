import 'package:bitbust/src/components/components.dart';
import 'package:bitbust/src/features/dashboard/views/notification_page.dart';
import 'package:bitbust/src/features/profile/data/controller/user_profile_controller.dart';
import 'package:bitbust/src/features/profile/views/widgets/profile_picture.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Homepage extends HookConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider).data;
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const LightHeader(
              text: "Good morning",
              fontSize: 12,
            ),
            BoldHeader(
              text: "${user?.firstName} ${user?.lastName}",
              fontSize: 14,
            )
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, NotificationPage.routeName);
            },
            child: SvgPicture.asset(AppAsset.notification),
          ),
          const XMargin(5),
          const ProfilePicture(radius: 12),
          const XMargin(15),
        ],
      ),
    );
  }
}

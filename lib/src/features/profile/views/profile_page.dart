import 'package:bitbust/src/components/bold_header.dart';
import 'package:bitbust/src/core/data_storage.dart';
import 'package:bitbust/src/features/authentication/views/login_page.dart';
import 'package:bitbust/src/features/profile/data/controller/user_profile_controller.dart';
import 'package:bitbust/src/features/profile/views/complete_profile.dart';
import 'package:bitbust/src/features/profile/views/security_page.dart';
import 'package:bitbust/src/features/profile/views/widgets/profile_item.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends StatefulHookConsumerWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProfileProvider).data;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: screenWidth(context, percent: .3),
        title: const BoldHeader(text: "Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.black,
                    ),
                    XMargin(screenWidth(context, percent: .2)),
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(color: AppColors.blueF0, borderRadius: BorderRadius.circular(12)),
                      child: SvgPicture.asset(AppAsset.camera, fit: BoxFit.scaleDown),
                    )
                  ],
                ),
                const YMargin(20),
                BoldHeader(text: "Hello, ${user?.firstName ?? ""}"),
                const YMargin(5),
                const LightHeader(text: "Manage your account & Preferences", fontSize: 14)
              ],
            ),
            const YMargin(20),
            ProfileItem(
              title: "My Profile",
              subtitle: "Your profile and personal information",
              function: () {
                Navigator.pushNamed(context, CompleteProfilePage.routeName);
              },
              asset: AppAsset.edit,
            ),
            ProfileItem(
              title: "Security",
              subtitle: "Manage how you access your account",
              function: () {
                Navigator.pushNamed(context, SecurityPage.routeName);
              },
              asset: AppAsset.security,
            ),
            ProfileItem(
              title: "Preferences",
              subtitle: "Settings and configurations",
              function: () {},
              asset: AppAsset.setting,
            ),
            ProfileItem(
              title: "Legal",
              subtitle: "Privacy Policy and T&C",
              function: () {},
              asset: AppAsset.setting,
            ),
            ProfileItem(
              title: "Logout",
              subtitle: "Exit the app",
              function: () {
                ref.read(dataStorageProvider).delete(Constants.token);
                Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName, (route) => false);
              },
              textColor: AppColors.redEF,
              asset: AppAsset.logout,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bitbust/main.dart';
import 'package:bitbust/src/components/bold_header.dart';
import 'package:bitbust/src/components/components.dart';
import 'package:bitbust/src/core/data_storage.dart';
import 'package:bitbust/src/features/authentication/views/login_page.dart';
import 'package:bitbust/src/features/profile/data/controller/update_user_profile.dart';
import 'package:bitbust/src/features/profile/data/controller/user_profile_controller.dart';
import 'package:bitbust/src/features/profile/views/complete_profile.dart';
import 'package:bitbust/src/features/profile/views/security_page.dart';
import 'package:bitbust/src/features/profile/views/widgets/profile_item.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:cross_file/src/types/interface.dart';
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
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.blueF0,
                        shape: BoxShape.circle,
                        image: user == null || user.profileImage == null
                            ? null
                            : DecorationImage(image: NetworkImage(user.profileImage!), fit: BoxFit.fill),
                      ),
                      width: 100,
                      height: 100,
                      child: ref.watch(updateUserProfileProvider).loading
                          ? const SizedBox(height: 30, width: 30, child: CircularProgressIndicator.adaptive())
                          : user == null || user.profileImage == null
                              ? const LogoText()
                              : null,
                    ),
                    XMargin(screenWidth(context, percent: .2)),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          backgroundColor: Colors.white,
                          builder: (context) {
                            return Column(
                              children: [
                                ListTile(
                                  onTap: () async {
                                    final image = await Helpers.takeImage();
                                    if (image == null) return;
                                    await uploadPhoto(image, context);
                                  },
                                  leading: const Icon(Icons.camera_alt),
                                  title: const Text("Take Photo"),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.phone_android),
                                  title: const Text("Select Picture"),
                                  onTap: () async {
                                    final image = await Helpers.selectImage();
                                    if (image == null) return;
                                    await uploadPhoto(image, context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(color: AppColors.blueF0, borderRadius: BorderRadius.circular(12)),
                        child: SvgPicture.asset(AppAsset.camera, fit: BoxFit.scaleDown),
                      ),
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

  Future<void> uploadPhoto(XFile image, BuildContext context) async {
    await ref.read(updateUserProfileProvider.notifier).updateProfilePicture(File(image.path));
    if (ref.read(updateUserProfileProvider).data != null) {
      Navigator.pop(context);
      ToastUtil.showSuccessToast(navigatorKey.currentContext ?? context, ref.read(updateUserProfileProvider).data!);
    }
  }
}

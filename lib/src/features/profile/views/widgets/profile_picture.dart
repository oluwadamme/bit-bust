import 'package:bitbust/src/components/components.dart';
import 'package:bitbust/src/features/profile/data/controller/update_user_profile.dart';
import 'package:bitbust/src/features/profile/data/controller/user_profile_controller.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePicture extends HookConsumerWidget {
  const ProfilePicture({super.key, this.radius = 50});
  final double radius;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider).data;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blueF0,
        shape: BoxShape.circle,
        image: user == null || user.profileImage == null
            ? null
            : DecorationImage(image: NetworkImage(user.profileImage!), fit: BoxFit.fill),
      ),
      width: radius * 2,
      height: radius * 2,
      child: ref.watch(updateUserProfileProvider).loading
          ? Center(
              child: SizedBox(
                  height: radius < 40 ? 10 : 30,
                  width: radius < 40 ? 10 : 30,
                  child: const CircularProgressIndicator.adaptive()))
          : user == null || user.profileImage == null
              ? Center(child: LogoText(fontSize: radius < 40 ? 8 : 16, color: AppColors.grey900))
              : null,
    );
  }
}

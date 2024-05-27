import 'dart:io';

import 'package:bitbust/main.dart';
import 'package:bitbust/src/features/profile/data/controller/state/update_user_profile_state.dart';
import 'package:bitbust/src/features/profile/data/controller/user_profile_controller.dart';
import 'package:bitbust/src/features/profile/data/model/update_profile_request.dart';
import 'package:bitbust/src/features/profile/data/repository/profile_repository.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final updateUserProfileProvider = StateNotifierProvider<UpdateUserProfileNotifier, UpdateUserProfileState>((ref) {
  return UpdateUserProfileNotifier(ref);
});

class UpdateUserProfileNotifier extends StateNotifier<UpdateUserProfileState> {
  UpdateUserProfileNotifier(this._ref) : super(UpdateUserProfileState());
  final Ref _ref;

  Future<void> updateProfile(UpdateProfileRequest request) async {
    state = UpdateUserProfileState(loading: true);
    try {
      final resp = await _ref.read(profileRepoProvider).changeUserProfile(request);
      if (resp.hasError()) {
        ToastUtil.showErrorToast(navigatorKey.currentContext!, resp.error!.message);
        state = UpdateUserProfileState(error: resp.error!.message);
      } else {
        await _ref.read(userProfileProvider.notifier).getProfile();
        state = UpdateUserProfileState(data: resp.response);
      }
    } catch (e) {
      Helpers.logc(e, error: true);
      state = UpdateUserProfileState(error: e.toString());
    }
  }

  Future<void> updateProfilePicture(File request) async {
    state = UpdateUserProfileState(loading: true);
    try {
      final resp = await _ref.read(profileRepoProvider).updateProfilePicture(request);
      if (resp.hasError()) {
        ToastUtil.showErrorToast(navigatorKey.currentContext!, resp.error!.message);
        state = UpdateUserProfileState(error: resp.error!.message);
      } else {
        await _ref.read(userProfileProvider.notifier).getProfile();
        state = UpdateUserProfileState(data: resp.response);
      }
    } catch (e) {
      Helpers.logc(e, error: true);
      state = UpdateUserProfileState(error: e.toString());
    }
  }
}

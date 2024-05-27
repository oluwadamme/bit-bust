import 'package:bitbust/main.dart';
import 'package:bitbust/src/features/profile/data/controller/state/user_profile_state.dart';
import 'package:bitbust/src/features/profile/data/repository/profile_repository.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userProfileProvider = StateNotifierProvider<UserProfileNotifier, UserProfileState>((ref) {
  return UserProfileNotifier(ref);
});

class UserProfileNotifier extends StateNotifier<UserProfileState> {
  UserProfileNotifier(this._ref) : super(UserProfileState());
  final Ref _ref;

  Future<void> getProfile() async {
    state = UserProfileState(loading: true);
    try {
      final resp = await _ref.read(profileRepoProvider).getProfile();
      if (resp.hasError()) {
        ToastUtil.showErrorToast(navigatorKey.currentContext!, resp.error!.message);
        state = UserProfileState(error: resp.error!.message);
      } else {
        state = UserProfileState(data: resp.response);
      }
    } catch (e) {
      Helpers.logc(e, error: true);
      state = UserProfileState(error: e.toString());
    }
  }
}

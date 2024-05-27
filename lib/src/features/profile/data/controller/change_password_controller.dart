import 'package:bitbust/main.dart';
import 'package:bitbust/src/features/profile/data/controller/state/change_password_state.dart';
import 'package:bitbust/src/features/profile/data/model/change_password_request.dart';
import 'package:bitbust/src/features/profile/data/repository/profile_repository.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final changePasswordProvider = StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>((ref) {
  return ChangePasswordNotifier(ref);
});

class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  ChangePasswordNotifier(this._ref) : super(ChangePasswordState());
  final Ref _ref;
  Future<void> createPassword(ChangePasswordRequest request) async {
    state = ChangePasswordState(loading: true);
    try {
      final resp = await _ref.read(profileRepoProvider).changePassword(request);
      if (resp.hasError()) {
        ToastUtil.showErrorToast(navigatorKey.currentContext!, resp.error!.message);
        state = ChangePasswordState(error: resp.error!.message);
      } else {
        state = ChangePasswordState(data: resp.response);
      }
    } catch (e) {
      Helpers.logc(e, error: true);
      state = ChangePasswordState(error: e.toString());
    }
  }
}

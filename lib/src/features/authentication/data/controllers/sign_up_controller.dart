import 'package:bitbust/main.dart';
import 'package:bitbust/src/features/authentication/data/controllers/states/sign_up_state.dart';
import 'package:bitbust/src/features/authentication/data/model/sign_up_request.dart';
import 'package:bitbust/src/features/authentication/data/repository/auth_repository.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  return SignUpNotifier(ref);
});

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier(this._ref) : super(SignUpState());
  final Ref _ref;
  Future<void> createAccount(SignUpRequest request) async {
    state = SignUpState(loading: true);
    try {
      final resp = await _ref.read(authRepoProvider).registration(request);
      if (resp.hasError()) {
        ToastUtil.showErrorToast(navigatorKey.currentContext!, resp.error!.message);
        state = SignUpState(error: resp.error!.message);
      } else {
        state = SignUpState(success: resp.response);
      }
    } catch (e) {
      Helpers.logc(e, error: true);
      state = SignUpState(error: e.toString());
    }
  }
}

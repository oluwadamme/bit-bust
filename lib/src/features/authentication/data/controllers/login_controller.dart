import 'package:bitbust/main.dart';
import 'package:bitbust/src/features/authentication/data/controllers/states/login_state.dart';
import 'package:bitbust/src/features/authentication/data/repository/auth_repository.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref);
});

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this._ref) : super(LoginState());
  final Ref _ref;

  Future<void> login({required String email, required String password}) async {
    state = LoginState(loading: true);
    try {
      final resp = await _ref.read(authRepoProvider).login(email, password);
      if (resp.hasError()) {
        ToastUtil.showErrorToast(navigatorKey.currentContext!, resp.error!.message);
        state = LoginState(error: resp.error!.message);
      } else {
        state = LoginState(success: resp.response);
      }
    } catch (e) {
      Helpers.logc(e, error: true);
      state = LoginState(error: e.toString());
    }
  }
}

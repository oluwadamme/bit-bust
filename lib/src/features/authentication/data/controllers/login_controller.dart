import 'package:bitbust/main.dart';
import 'package:bitbust/src/core/core.dart';
import 'package:bitbust/src/features/authentication/data/controllers/states/login_state.dart';
import 'package:bitbust/src/features/authentication/data/repository/auth_repository.dart';
import 'package:bitbust/src/features/profile/data/controller/user_profile_controller.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier(ref);
});

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this._ref) : super(LoginState());
  final Ref _ref;
  final LocalAuthentication auth = LocalAuthentication();
  Future<void> login({required String email, required String password}) async {
    state = LoginState(loading: true);
    try {
      final resp = await _ref.read(authRepoProvider).login(email, password);
      if (resp.hasError()) {
        ToastUtil.showErrorToast(navigatorKey.currentContext!, resp.error!.message);
        state = LoginState(error: resp.error!.message);
      } else {
        await verifyOTP(email: email);

        await _ref.read(dataStorageProvider).write(Constants.password, password);
      }
    } catch (e) {
      Helpers.logc(e, error: true);
      state = LoginState(error: e.toString());
    }
  }

  Future<void> verifyOTP({required String email}) async {
    state = LoginState(loading: true);
    try {
      final resp = await _ref.read(authRepoProvider).verifyOTP(email, "123456");
      if (resp.hasError()) {
        ToastUtil.showErrorToast(navigatorKey.currentContext!, resp.error!.message);
        state = LoginState(error: resp.error!.message);
      } else {
        await _ref.read(dataStorageProvider).write(Constants.token, resp.response);
        await _ref.read(userProfileProvider.notifier).getProfile();
        await _ref.read(dataStorageProvider).write(Constants.email, email);
        state = LoginState(success: resp.response);
      }
    } catch (e) {
      Helpers.logc(e, error: true);
      state = LoginState(error: e.toString());
    }
  }

  Future<bool> setupBiometric() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate = canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    final List<BiometricType> availableBiometrics = await auth.getAvailableBiometrics();

    if (canAuthenticate == false || availableBiometrics.isEmpty) {
      ToastUtil.showErrorToast(navigatorKey.currentContext!, "Biometric is not available on this device");
      return false;
    }
    try {
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate yourself', options: const AuthenticationOptions(biometricOnly: true));
      if (didAuthenticate) {
        return true;
      }
      return false;
    } on PlatformException catch (e) {
      Helpers.logc(e);
      ToastUtil.showErrorToast(navigatorKey.currentContext!, e.message ?? e.details ?? "Cannot validate biometric");
      return false;
    }
  }
}

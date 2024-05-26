import 'package:bitbust/src/components/components.dart';
import 'package:bitbust/src/features/authentication/views/create_account_page.dart';
import 'package:bitbust/src/features/authentication/views/login_page.dart';
import 'package:bitbust/src/features/dashboard/views/dashboard.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen.routeName:
        return FadeRoute(page: const SplashScreen());
      case CreateAccountPage.routeName:
        return ScaleRoute(page: const CreateAccountPage());
      case DashboardPage.routeName:
        return ScaleRoute(page: const DashboardPage());
      case LoginPage.routeName:
        return ScaleRoute(page: const LoginPage());
      // case RecoverPasswordPage.routeName:
      //   return FadeRoute(page: const RecoverPasswordPage());
      // case PinPage.routeName:
      //   return FadeRoute(page: PinPage(request: settings.arguments as RegisterRequest));
      // case NewPasswordPage.routeName:
      //   return SizeRoute(page: const NewPasswordPage());
      // case VerifyIdentityPage.routeName:
      //   return FadeRoute(page: VerifyIdentityPage(email: settings.arguments as String));
      default:
        return FadeRoute(page: const SplashScreen());
    }
  }
}

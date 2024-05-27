import 'package:bitbust/src/components/components.dart';
import 'package:bitbust/src/features/authentication/views/create_account_page.dart';
import 'package:bitbust/src/features/authentication/views/login_page.dart';
import 'package:bitbust/src/features/dashboard/views/dashboard.dart';
import 'package:bitbust/src/features/dashboard/views/notification_page.dart';
import 'package:bitbust/src/features/profile/views/complete_profile.dart';
import 'package:bitbust/src/features/profile/views/security_page.dart';
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
      case NotificationPage.routeName:
        return FadeRoute(page: const NotificationPage());
      case SecurityPage.routeName:
        return FadeRoute(page: const SecurityPage());
      case CompleteProfilePage.routeName:
        return SizeRoute(page: const CompleteProfilePage());
      // case VerifyIdentityPage.routeName:
      //   return FadeRoute(page: VerifyIdentityPage(email: settings.arguments as String));
      default:
        return FadeRoute(page: const SplashScreen());
    }
  }
}

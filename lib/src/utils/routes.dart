import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case SplashScreen.routeName:
      //   return FadeRoute(page: const SplashScreen());
      // case OnboardingScreen.routeName:
      //   return ScaleRoute(page: const OnboardingScreen());
      // case RegisterScreen.routeName:
      //   return ScaleRoute(page: const RegisterScreen());
      // case VerifyEmailScreen.routeName:
      //   return ScaleRoute(page: VerifyEmailScreen(token: settings.arguments as String));
      // case AboutYouScreen.routeName:
      //   return ScaleRoute(page: const AboutYouScreen());
      // case CompleteReg.routeName:
      //   return ScaleRoute(page: CompleteReg(name: settings.arguments as String));
      // case HomeScreen.routeName:
      //   return ScaleRoute(page: const HomeScreen());
      // case LoginScreen.routeName:
      //   return SlideRightRoute(page: const LoginScreen());
      // case RecoverPasswordPage.routeName:
      //   return FadeRoute(page: const RecoverPasswordPage());
      // case PinPage.routeName:
      //   return FadeRoute(page: PinPage(request: settings.arguments as RegisterRequest));
      // case NewPasswordPage.routeName:
      //   return SizeRoute(page: const NewPasswordPage());
      // case VerifyIdentityPage.routeName:
      //   return FadeRoute(page: VerifyIdentityPage(email: settings.arguments as String));
      // default:
      //   return FadeRoute(page: const SplashScreen());
    }
  }
}

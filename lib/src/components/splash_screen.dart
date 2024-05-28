// ignore_for_file: use_build_context_synchronously

import 'package:bitbust/src/components/components.dart';
import 'package:bitbust/src/core/data_storage.dart';
import 'package:bitbust/src/features/authentication/views/create_account_page.dart';
import 'package:bitbust/src/features/authentication/views/login_page.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "/";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      navigate();
    });
  }

  final hive = DataStorage();
  void navigate() async {
    if (await hive.isExists(Constants.email)) {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    } else {
      Navigator.pushReplacementNamed(context, CreateAccountPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: LogoText(),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:bitbust/src/components/components.dart';
import 'package:bitbust/src/core/data_storage.dart';
import 'package:bitbust/src/features/authentication/data/controllers/login_controller.dart';
import 'package:bitbust/src/features/authentication/data/repository/auth_repository.dart';
import 'package:bitbust/src/features/authentication/views/create_account_page.dart';
import 'package:bitbust/src/features/dashboard/views/dashboard.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends StatefulHookConsumerWidget {
  const LoginPage({super.key});
  static const String routeName = "/login";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (await ref.read(dataStorageProvider).isExists(Constants.email)) {
        emailController.text = (await ref.read(dataStorageProvider).read(Constants.email))!;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final obscured = useState(true);
    return Scaffold(
      appBar: AppBar(leading: const SizedBox.shrink()),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(screenHeight(context, percent: .05)),
              const Center(child: LogoText(fontSize: 24, color: AppColors.grey900)),
              YMargin(screenHeight(context, percent: .06)),
              const BoldHeader(text: "Welcome Back"),
              const LightHeader(
                fontSize: 10,
                text:
                    "We’ve been expecting you, please enter your login \ndetails below to securely access your account.",
              ),
              const YMargin(30),
              InputField(
                controller: emailController,
                hint: "Email Address",
                prefixIcon: SvgPicture.asset(AppAsset.sms, fit: BoxFit.scaleDown),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email Address cannot be empty";
                  }
                  if (!value.isValidEmail()) {
                    return "Email Address is not valid";
                  }

                  return null;
                },
              ),
              const YMargin(15),
              InputField(
                controller: passwordController,
                hint: "Password",
                prefixIcon: SvgPicture.asset(AppAsset.lock, fit: BoxFit.scaleDown),
                suffixIcon: GestureDetector(
                    onTap: () {
                      obscured.value = !obscured.value;
                    },
                    child: Icon(obscured.value ? Icons.visibility : Icons.visibility_off, color: AppColors.grey61)),
                keyboardType: TextInputType.visiblePassword,
                onbscureText: obscured.value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Password cannot be empty";
                  }
                  return null;
                },
              ),
              const YMargin(50),
              Center(
                child: CustomButton(
                  text: "Login",
                  loading: ref.watch(loginProvider).loading,
                  function: () async {
                    Helpers.closeKeyboard(context);
                    if (formKey.currentState!.validate()) {
                      await ref
                          .read(loginProvider.notifier)
                          .login(email: emailController.text, password: passwordController.text);
                      if (ref.read(loginProvider).success != null) {
                        Navigator.pushNamed(context, DashboardPage.routeName);
                      }
                    }
                  },
                  width: 287,
                ),
              ),
              const YMargin(20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CreateAccountPage.routeName);
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Don’t have account? ",
                      style: normalStyle(12, AppColors.brown53),
                      children: [
                        TextSpan(
                          text: " Create a new account",
                          style: normalStyle(12, AppColors.green6f),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              YMargin(screenHeight(context, percent: .15)),
              GestureDetector(onTap: () {}, child: Center(child: SvgPicture.asset(AppAsset.fingerprint)))
            ],
          ),
        ),
      ),
    );
  }
}

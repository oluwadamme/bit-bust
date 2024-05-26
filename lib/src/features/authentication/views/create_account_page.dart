// ignore_for_file: use_build_context_synchronously

import 'package:bitbust/main.dart';
import 'package:bitbust/src/components/components.dart';
import 'package:bitbust/src/components/custom_button.dart';
import 'package:bitbust/src/core/core.dart';
import 'package:bitbust/src/features/authentication/data/controllers/sign_up_controller.dart';
import 'package:bitbust/src/features/authentication/data/model/sign_up_request.dart';
import 'package:bitbust/src/features/authentication/views/login_page.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateAccountPage extends StatefulHookConsumerWidget {
  const CreateAccountPage({super.key});
  static const String routeName = "/create_account";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends ConsumerState<CreateAccountPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final midNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final obscured = useState(true);
    final obscured1 = useState(true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const LogoText(fontSize: 24, color: Colors.black),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YMargin(screenHeight(context, percent: .02)),
              const BoldHeader(text: "Create Account"),
              const LightHeader(
                text: "Let’s get you setup!",
                fontSize: 10,
              ),
              const YMargin(20),
              InputField(
                controller: firstNameController,
                hint: "First Name",
                keyboardType: TextInputType.name,
                prefixIcon: SvgPicture.asset(AppAsset.profile, fit: BoxFit.scaleDown),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "First name cannot be empty";
                  }
                  return null;
                },
              ),
              const YMargin(15),
              InputField(
                controller: lastNameController,
                hint: "Last Name",
                keyboardType: TextInputType.name,
                prefixIcon: SvgPicture.asset(AppAsset.profile, fit: BoxFit.scaleDown),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Last name cannot be empty";
                  }
                  return null;
                },
              ),
              const YMargin(15),
              InputField(
                keyboardType: TextInputType.name,
                controller: midNameController,
                hint: "Middle Name (optional)",
                prefixIcon: SvgPicture.asset(AppAsset.profile, fit: BoxFit.scaleDown),
              ),
              const YMargin(15),
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
                controller: phoneController,
                hint: "Phone Number",
                prefixIcon: SvgPicture.asset(AppAsset.call, fit: BoxFit.scaleDown),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Phone Number cannot be empty";
                  }
                  if (value.length < 10) {
                    return "Phone Number is not valid";
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
                  if (!value.isValidPassword()) {
                    return "Password Must be more than 8 characters and contain at least one capital letter, one number and one special character";
                  }
                  return null;
                },
              ),
              const YMargin(15),
              InputField(
                controller: confirmPasswordController,
                hint: "Confirm Password",
                prefixIcon: SvgPicture.asset(AppAsset.lock, fit: BoxFit.scaleDown),
                suffixIcon: GestureDetector(
                    onTap: () {
                      obscured1.value = !obscured1.value;
                    },
                    child: Icon(obscured1.value ? Icons.visibility : Icons.visibility_off, color: AppColors.grey61)),
                keyboardType: TextInputType.visiblePassword,
                onbscureText: obscured1.value,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Confirm Password cannot be empty";
                  }
                  if (!value.isValidPassword()) {
                    return "Password Must be more than 8 characters and contain at least one capital letter, one number and one special character";
                  }
                  if (value != passwordController.text.trim()) {
                    return "Passwords do not match";
                  }
                  return null;
                },
              ),
              const YMargin(40),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "By clicking on sign up, you agree to the Bitbust ",
                    style: normalStyle(12, AppColors.brown53),
                    children: [
                      TextSpan(
                        text: "Terms of Service\n",
                        style: normalStyle(12, AppColors.green6f),
                      ),
                      TextSpan(
                        text: "and ",
                        style: normalStyle(12, AppColors.brown53),
                      ),
                      TextSpan(
                        text: "Privacy Policy",
                        style: normalStyle(12, AppColors.green6f),
                      ),
                    ],
                  ),
                ),
              ),
              const YMargin(20),
              Center(
                child: CustomButton(
                  text: "Sign Up",
                  loading: ref.watch(signUpProvider).loading,
                  function: () async {
                    Helpers.closeKeyboard(context);
                    if (formKey.currentState!.validate()) {
                      final request = SignUpRequest(
                        email: emailController.text,
                        middleName: midNameController.text,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        password: passwordController.text,
                        passwordConfirmation: confirmPasswordController.text,
                        phone: phoneController.text,
                        phoneToken: PushNotificationService.token,
                      );
                      await ref.read(signUpProvider.notifier).createAccount(request);
                      if (ref.read(signUpProvider).success != null) {
                        Navigator.pushNamed(context, LoginPage.routeName);
                        ToastUtil.showSuccessToast(
                            navigatorKey.currentContext ?? context, ref.read(signUpProvider).success!);
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
                    Navigator.pushNamed(context, LoginPage.routeName);
                  },
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Already have account? ",
                      style: normalStyle(12, AppColors.brown53),
                      children: [
                        TextSpan(
                          text: " Log in",
                          style: normalStyle(12, AppColors.green6f),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

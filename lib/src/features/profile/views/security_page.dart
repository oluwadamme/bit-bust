// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:bitbust/main.dart';
import 'package:bitbust/src/components/components.dart';
import 'package:bitbust/src/features/profile/data/controller/change_password_controller.dart';
import 'package:bitbust/src/features/profile/data/model/change_password_request.dart';
import 'package:bitbust/src/features/profile/views/widgets/profile_item.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SecurityPage extends StatefulHookConsumerWidget {
  const SecurityPage({super.key});
  static const String routeName = "/security";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SecurityPageState();
}

class _SecurityPageState extends ConsumerState<SecurityPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const CustomBackButton(),
        title: const BoldHeader(text: "Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YMargin(screenHeight(context, percent: .05)),
            const BoldHeader(text: "Security"),
            YMargin(screenHeight(context, percent: .05)),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: const Color(0xff3F7DCC).withOpacity(.12), blurRadius: 12)],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ProfileItem(
                title: "Password",
                subtitle: "Change account password",
                asset: AppAsset.password,
                function: () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      elevation: 5,
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5.0,
                            sigmaY: 5.0,
                          ),
                          child: HookConsumer(builder: (context, reader, child) {
                            final obscured = useState(true);
                            final obscured1 = useState(true);
                            final passwordController = useTextEditingController();
                            final oldPasswordController = useTextEditingController();
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [BoxShadow(color: const Color(0xff3F7DCC).withOpacity(.12), blurRadius: 12)],
                              ),
                              padding:
                                  const EdgeInsets.all(21).copyWith(bottom: MediaQuery.viewInsetsOf(context).bottom),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Change Password",
                                          style: boldStyle(20, AppColors.grey2E,
                                              family: GoogleFonts.openSans().fontFamily),
                                        ),
                                        GestureDetector(
                                          onTap: () => Navigator.pop(context),
                                          child: SvgPicture.asset("assets/svg/fi_x.svg"),
                                        )
                                      ],
                                    ),
                                    const YMargin(20),
                                    const LightHeader(text: "Update your account password", fontSize: 14),
                                    const YMargin(20),
                                    Text(
                                      "Old Password",
                                      style: normalStyle(14, AppColors.grey5D),
                                    ),
                                    InputField(
                                      controller: oldPasswordController,
                                      hint: "Enter your old password",
                                      suffixIcon: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              obscured.value = !obscured.value;
                                            },
                                            child: BoldHeader(
                                              text: obscured.value ? "Show" : "Hide",
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      keyboardType: TextInputType.visiblePassword,
                                      onbscureText: obscured.value,
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return "Password cannot be empty";
                                        }

                                        return null;
                                      },
                                    ),
                                    const YMargin(15),
                                    Text(
                                      "New Password",
                                      style: normalStyle(14, AppColors.grey5D),
                                    ),
                                    InputField(
                                      controller: passwordController,
                                      hint: "Enter your new password",
                                      suffixIcon: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              obscured1.value = !obscured1.value;
                                            },
                                            child: BoldHeader(
                                              text: obscured1.value ? "Show" : "Hide",
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      keyboardType: TextInputType.visiblePassword,
                                      onbscureText: obscured1.value,
                                      validator: (value) {
                                        if (value == null || value.trim().isEmpty) {
                                          return "New Password cannot be empty";
                                        }
                                        if (!value.isValidPassword()) {
                                          return "New Password is not valid";
                                        }
                                        return null;
                                      },
                                    ),
                                    const YMargin(10),
                                    RichText(
                                      text: TextSpan(
                                        style: normalStyle(12, AppColors.grey8B),
                                        text: "Must be more than ",
                                        children: [
                                          TextSpan(
                                            style: normalStyle(12, AppColors.grey17),
                                            text: "8 characters ",
                                          ),
                                          TextSpan(
                                            style: normalStyle(12, AppColors.grey8B),
                                            text: "and contain at least ",
                                          ),
                                          TextSpan(
                                            style: normalStyle(12, AppColors.grey17),
                                            text: "one capital letter, one number ",
                                          ),
                                          TextSpan(
                                            style: normalStyle(12, AppColors.grey8B),
                                            text: "and ",
                                          ),
                                          TextSpan(
                                            style: normalStyle(12, AppColors.grey17),
                                            text: "one special character",
                                          )
                                        ],
                                      ),
                                    ),
                                    const YMargin(50),
                                    Center(
                                      child: CustomButton(
                                        text: "Update",
                                        function: () async {
                                          Helpers.closeKeyboard(context);
                                          if (formKey.currentState!.validate()) {
                                            final request = ChangePasswordRequest(
                                              password: passwordController.text,
                                              oldPassword: oldPasswordController.text,
                                              otp: "123456",
                                              passwordConfirmation: passwordController.text,
                                            );
                                            await reader.read(changePasswordProvider.notifier).createPassword(request);
                                            if (reader.read(changePasswordProvider).data != null) {
                                              Navigator.pop(context);
                                              ToastUtil.showSuccessToast(navigatorKey.currentContext ?? context,
                                                  reader.read(changePasswordProvider).data!);
                                            }
                                          }
                                        },
                                        loading: reader.watch(changePasswordProvider).loading,
                                        width: 287,
                                      ),
                                    ),
                                    const YMargin(50),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      },
                      isScrollControlled: true,
                      barrierColor: Colors.white.withOpacity(.12));
                },
                verticalPadding: 3,
              ),
            ),
            const YMargin(15),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: const Color(0xff3F7DCC).withOpacity(.12), blurRadius: 12)],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ProfileItem(
                title: "Transaction PIN",
                subtitle: "Change Transaction PIN",
                asset: AppAsset.pin,
                function: () {},
                verticalPadding: 3,
              ),
            )
          ],
        ),
      ),
    );
  }
}

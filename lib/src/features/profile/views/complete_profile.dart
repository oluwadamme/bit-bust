// ignore_for_file: use_build_context_synchronously

import 'package:bitbust/main.dart';
import 'package:bitbust/src/components/components.dart';
import 'package:bitbust/src/features/profile/data/controller/update_user_profile.dart';
import 'package:bitbust/src/features/profile/data/controller/user_profile_controller.dart';
import 'package:bitbust/src/features/profile/data/model/update_profile_request.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class CompleteProfilePage extends StatefulHookConsumerWidget {
  const CompleteProfilePage({super.key});
  static const String routeName = "/complete_profile";
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends ConsumerState<CompleteProfilePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final midNameController = TextEditingController();
  final emailController = TextEditingController();
  final postalCode = TextEditingController();
  final streetNo = TextEditingController();
  final streetName = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final dob = TextEditingController();
  DateTime? _date;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final user = ref.watch(userProfileProvider).data;
      if (user != null) {
        if (user.city != null) {
          city.text = user.city!;
        }
        if (user.email != null) {
          emailController.text = user.email!;
        }
        if (user.firstName != null) {
          firstNameController.text = user.firstName!;
        }
        if (user.lastName != null) {
          lastNameController.text = user.lastName!;
        }
        if (user.middleName != null) {
          midNameController.text = user.middleName!;
        }

        if (user.postalCode != null) {
          postalCode.text = user.postalCode!;
        }
        if (user.state != null) {
          state.text = user.state!;
        }
        if (user.streetName != null) {
          streetName.text = user.streetName!;
        }
        if (user.streetNo != null) {
          streetNo.text = user.streetNo!;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gender = useState<String?>(null);
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        centerTitle: true,
        title: const BoldHeader(
          text: "Complete Profile",
          fontSize: 16,
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      controller: firstNameController,
                      label: "First Name",
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "First name cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  const XMargin(20),
                  Expanded(
                    child: InputField(
                      controller: lastNameController,
                      label: "Last Name",
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Last name cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const YMargin(15),
              InputField(
                controller: midNameController,
                label: "Middle Name",
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Middle name cannot be empty";
                  }
                  return null;
                },
              ),
              const YMargin(15),
              InputField(
                controller: emailController,
                hint: "Email Address",
                label: "Email Address",
                keyboardType: TextInputType.emailAddress,
                enabled: false,
              ),
              const YMargin(15),
              InputField(
                controller: postalCode,
                label: "Postal Code",
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email Address cannot be empty";
                  }
                  return null;
                },
              ),
              const YMargin(15),
              InputField(
                controller: streetNo,
                label: "Contact Address",
                hint: "Street No",
                keyboardType: TextInputType.number,
                validator: (value) {
                  return null;
                },
              ),
              const YMargin(15),
              InputField(
                controller: streetName,
                hint: "Street Name",
                keyboardType: TextInputType.streetAddress,
                validator: (value) {
                  return null;
                },
              ),
              const YMargin(15),
              InputField(
                controller: city,
                hint: "City",
                keyboardType: TextInputType.text,
                validator: (value) {
                  return null;
                },
              ),
              const YMargin(15),
              InputField(
                controller: state,
                hint: "State",
                keyboardType: TextInputType.text,
                validator: (value) {
                  return null;
                },
              ),
              const YMargin(30),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Helpers.closeKeyboard(context);
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1980),
                          lastDate: DateTime(2100),
                          currentDate: DateTime.now(),
                        );
                        if (date != null) {
                          setState(() {
                            _date = date;
                            dob.text = DateFormat("dd/MM/yyyy").format(date);
                          });
                        }
                      },
                      child: AbsorbPointer(
                        child: InputField(
                          controller: dob,
                          hint: "DD/MM/YY",
                          label: "D.O.B",
                          validator: (value) {
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const XMargin(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gender",
                          style: mediumStyle(12, AppColors.grey29),
                        ),
                        const YMargin(5),
                        Container(
                          decoration: const BoxDecoration(color: AppColors.greyF2),
                          child: DropdownButton(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            underline: const SizedBox.shrink(),
                            elevation: 2,
                            value: gender.value,
                            onChanged: (value) {
                              gender.value = value;
                            },
                            hint: Text(
                              "Select Option",
                              style: normalStyle(12, AppColors.grey900),
                            ),
                            items: ["male", "female"]
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const XMargin(20),
                ],
              ),
              const YMargin(50),
              Center(
                child: CustomButton(
                  text: "Continue",
                  function: () async {
                    Helpers.closeKeyboard(context);
                    if (formKey.currentState!.validate()) {
                      final request = UpdateProfileRequest(
                        city: city.text,
                        country: "Nigeria",
                        dateOfBirth: _date,
                        gender: gender.value,
                        middleName: midNameController.text,
                        postalCode: postalCode.text,
                        state: state.text,
                        streetName: streetName.text,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        streetNo: int.parse(streetNo.text),
                      );
                      await ref.read(updateUserProfileProvider.notifier).updateProfile(request);
                      if (ref.read(updateUserProfileProvider).data != null) {
                        Navigator.pop(context);
                        ToastUtil.showSuccessToast(
                            navigatorKey.currentContext ?? context, ref.read(updateUserProfileProvider).data!);
                      }
                    }
                  },
                  loading: ref.watch(updateUserProfileProvider).loading,
                  width: 287,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

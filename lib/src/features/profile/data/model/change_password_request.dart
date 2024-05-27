// To parse this JSON data, do
//
//     final changePasswordRequest = changePasswordRequestFromJson(jsonString);

import 'dart:convert';

ChangePasswordRequest changePasswordRequestFromJson(String str) => ChangePasswordRequest.fromJson(json.decode(str));

String changePasswordRequestToJson(ChangePasswordRequest data) => json.encode(data.toJson());

class ChangePasswordRequest {
  final String? password;
  final String? passwordConfirmation;
  final String? oldPassword;
  final String? otp;

  ChangePasswordRequest({
    this.password,
    this.passwordConfirmation,
    this.oldPassword,
    this.otp,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) => ChangePasswordRequest(
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
        oldPassword: json["old_password"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "password_confirmation": passwordConfirmation,
        "old_password": oldPassword,
        "otp": otp,
      };
}

// To parse this JSON data, do
//
//     final signUpRequest = signUpRequestFromJson(jsonString);

import 'dart:convert';


SignUpRequest signUpRequestFromJson(String str) => SignUpRequest.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? email;
  final String? phone;
  final String? password;
  final String? passwordConfirmation;
  final String? phoneToken;

  SignUpRequest({
    this.firstName,
    this.lastName,
    this.middleName,
    this.email,
    this.phone,
    this.password,
    this.passwordConfirmation,
    this.phoneToken,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        password: json["password"],
        passwordConfirmation: json["password_confirmation"],
        phoneToken: json["phone_token"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "middle_name": middleName,
        "email": email,
        "phone": phone,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "phone_token": phoneToken,
      };
}

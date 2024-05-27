// To parse this JSON data, do
//
//     final updateProfileRequest = updateProfileRequestFromJson(jsonString);

import 'dart:convert';

UpdateProfileRequest updateProfileRequestFromJson(String str) => UpdateProfileRequest.fromJson(json.decode(str));

String updateProfileRequestToJson(UpdateProfileRequest data) => json.encode(data.toJson());

class UpdateProfileRequest {
  final String? middleName;
  final String? firstName;
  final String? lastName;
  final int? streetNo;
  final String? streetName;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final DateTime? dateOfBirth;
  final String? gender;

  UpdateProfileRequest({
    this.middleName,
    this.firstName,
    this.lastName,
    this.streetNo,
    this.streetName,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.dateOfBirth,
    this.gender,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) => UpdateProfileRequest(
        middleName: json["middle_name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        streetNo: json["street_no"],
        streetName: json["street_name"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postal_code"],
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "middle_name": middleName,
        "first_name": firstName,
        "last_name": lastName,
        "street_no": streetNo,
        "street_name": streetName,
        "city": city,
        "state": state,
        "country": country,
        "postal_code": postalCode,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
      };
}

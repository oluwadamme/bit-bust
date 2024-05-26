// To parse this JSON data, do
//
//     final userProfileInfo = userProfileInfoFromJson(jsonString);

import 'dart:convert';

UserProfileInfo userProfileInfoFromJson(String str) => UserProfileInfo.fromJson(json.decode(str));

String userProfileInfoToJson(UserProfileInfo data) => json.encode(data.toJson());

class UserProfileInfo {
  final String? uuid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final bool? the2FaEnabled;
  final String? middleName;
  final String? profileImage;
  final String? streetNo;
  final String? streetName;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? phoneToken;
  final bool? isVerified;
  final bool? pin;
  final Tier? tier;
  final bool? isBvnVerified;
  final bool? isNinVerified;

  UserProfileInfo({
    this.uuid,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.the2FaEnabled,
    this.middleName,
    this.profileImage,
    this.streetNo,
    this.streetName,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.phoneToken,
    this.isVerified,
    this.pin,
    this.tier,
    this.isBvnVerified,
    this.isNinVerified,
  });

  factory UserProfileInfo.fromJson(Map<String, dynamic> json) => UserProfileInfo(
        uuid: json["uuid"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phone: json["phone"],
        the2FaEnabled: json["2fa_enabled"],
        middleName: json["middle_name"],
        profileImage: json["profile_image"],
        streetNo: json["street_no"],
        streetName: json["street_name"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postal_code"],
        phoneToken: json["phone_token"],
        isVerified: json["is_verified"],
        pin: json["pin"],
        tier: json["tier"] == null ? null : Tier.fromJson(json["tier"]),
        isBvnVerified: json["is_bvn_verified"],
        isNinVerified: json["is_nin_verified"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "2fa_enabled": the2FaEnabled,
        "middle_name": middleName,
        "profile_image": profileImage,
        "street_no": streetNo,
        "street_name": streetName,
        "city": city,
        "state": state,
        "country": country,
        "postal_code": postalCode,
        "phone_token": phoneToken,
        "is_verified": isVerified,
        "pin": pin,
        "tier": tier?.toJson(),
        "is_bvn_verified": isBvnVerified,
        "is_nin_verified": isNinVerified,
      };
}

class Tier {
  final String? name;
  final dynamic minimumBalance;
  final dynamic interestRate;
  final String? monthlyCharge;
  final String? withdrawalLimit;
  final String? monthlyWithdrawalLimit;
  final String? depositLimit;
  final String? monthlyDepositLimit;
  final String? cashbackPercentage;
  final String? minimumDeposit;

  Tier({
    this.name,
    this.minimumBalance,
    this.interestRate,
    this.monthlyCharge,
    this.withdrawalLimit,
    this.monthlyWithdrawalLimit,
    this.depositLimit,
    this.monthlyDepositLimit,
    this.cashbackPercentage,
    this.minimumDeposit,
  });

  factory Tier.fromJson(Map<String, dynamic> json) => Tier(
        name: json["name"],
        minimumBalance: json["minimumBalance"],
        interestRate: json["interestRate"],
        monthlyCharge: json["monthlyCharge"],
        withdrawalLimit: json["withdrawalLimit"],
        monthlyWithdrawalLimit: json["monthlyWithdrawalLimit"],
        depositLimit: json["depositLimit"],
        monthlyDepositLimit: json["monthlyDepositLimit"],
        cashbackPercentage: json["cashbackPercentage"],
        minimumDeposit: json["minimumDeposit"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "minimumBalance": minimumBalance,
        "interestRate": interestRate,
        "monthlyCharge": monthlyCharge,
        "withdrawalLimit": withdrawalLimit,
        "monthlyWithdrawalLimit": monthlyWithdrawalLimit,
        "depositLimit": depositLimit,
        "monthlyDepositLimit": monthlyDepositLimit,
        "cashbackPercentage": cashbackPercentage,
        "minimumDeposit": minimumDeposit,
      };
}

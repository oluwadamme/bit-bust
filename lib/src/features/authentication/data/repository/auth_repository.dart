import 'dart:math';

import 'package:bitbust/src/core/core.dart';
import 'package:bitbust/src/features/authentication/data/model/sign_up_request.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepoProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

class AuthRepository extends ApiClient {
  String _generateAlphanumeric(int length) {
    final chars = dotenv.env["REG_KEY"] ?? "";
    final random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }

  Future<RequestRes> registration(SignUpRequest request) async {
    try {
      final response = await post(Endpoints.register,
          data: request.toJson(), options: Options(headers: {"x-api-key": _generateAlphanumeric(42)}));

      return RequestRes(response: response['message']);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> login(String email, String password) async {
    try {
      final response = await post(
        Endpoints.login,
        data: {
          "email": email,
          "password": password,
          "phone_token": PushNotificationService.token,
        },
      );

      return RequestRes(response: response['data']);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> verifyOTP(String email, String otp) async {
    try {
      final response = await post(
        Endpoints.verifyOTP,
        data: {"email": email, "otp": otp},
      );

      return RequestRes(response: response['data']['token']);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }
}

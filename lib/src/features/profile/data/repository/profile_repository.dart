import 'dart:io';

import 'package:bitbust/src/core/core.dart';
import 'package:bitbust/src/features/profile/data/model/change_password_request.dart';
import 'package:bitbust/src/features/profile/data/model/update_profile_request.dart';
import 'package:bitbust/src/features/profile/data/model/user_profile_info.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profileRepoProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

class ProfileRepository extends ApiClient {
  Future<RequestRes> getProfile() async {
    try {
      final response = await get(Endpoints.profile).then((value) => value['data']);
      final user = UserProfileInfo.fromJson(response);
      return RequestRes(response: user);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> changePassword(ChangePasswordRequest request) async {
    try {
      final response = await post(Endpoints.changePassword, data: request.toJson()).then((value) => value['message']);
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> changeUserProfile(UpdateProfileRequest request) async {
    try {
      final response = await post(Endpoints.updateUser, data: request.toJson()).then((value) => value['message']);
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }

  Future<RequestRes> updateProfilePicture(File image) async {
    try {
      final response = await post(Endpoints.updateUser, data: {"image": image}).then((value) => value['message']);
      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }
}

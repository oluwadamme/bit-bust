import 'package:bitbust/src/core/core.dart';
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
}

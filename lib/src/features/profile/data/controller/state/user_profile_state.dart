import 'package:bitbust/src/features/profile/data/model/user_profile_info.dart';

class UserProfileState {
  final bool loading;
  final UserProfileInfo? data;
  final String? error;

  UserProfileState({this.loading = false, this.data, this.error});
}

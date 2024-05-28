import 'package:bitbust/main.dart';
import 'package:bitbust/src/features/dashboard/data/controllers/states/notification_state.dart';
import 'package:bitbust/src/features/dashboard/data/repository/notification_repository.dart';
import 'package:bitbust/src/utils/helpers.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notificationProvider = StateNotifierProvider<NotificationNotifier, NotificationState>((ref) {
  return NotificationNotifier(ref);
});

class NotificationNotifier extends StateNotifier<NotificationState> {
  NotificationNotifier(this._ref) : super(NotificationState(data: []));
  final Ref _ref;

  Future<void> fetchAllNotifications() async {
    state = NotificationState(loading: true, data: []);
    try {
      final resp = await _ref.read(notificationRepoProvider).getNotifications();
      if (resp.hasError()) {
        ToastUtil.showErrorToast(navigatorKey.currentContext!, resp.error!.message);
        state = NotificationState(error: resp.error!.message, data: []);
      } else {
        state = NotificationState(data: resp.response);
      }
    } catch (e) {
      Helpers.logc(e, error: true);
      state = NotificationState(error: e.toString(), data: []);
    }
  }
}

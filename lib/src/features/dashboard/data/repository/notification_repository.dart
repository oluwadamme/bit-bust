import 'package:bitbust/src/core/core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final notificationRepoProvider = Provider<NotificationRepository>((ref) {
  return NotificationRepository();
});

class NotificationRepository extends ApiClient {
  Future<RequestRes> getNotifications() async {
    try {
      final List<dynamic> response = await get(Endpoints.notification).then((value) => value['data']);

      return RequestRes(response: response);
    } catch (e) {
      return RequestRes(error: ErrorRes(message: e.toString()));
    }
  }
}

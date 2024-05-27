import 'package:hooks_riverpod/hooks_riverpod.dart';

final dashNavProvider = StateNotifierProvider<DashNavNotifier, int>((ref) {
  return DashNavNotifier();
});

class DashNavNotifier extends StateNotifier<int> {
  DashNavNotifier() : super(0);
  void updatePage(int page) => state = page;
}

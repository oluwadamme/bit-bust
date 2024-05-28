class NotificationState<T> {
  final bool loading;
  final List<T> data;
  final String? error;

  NotificationState({this.loading = false, required this.data, this.error});
}

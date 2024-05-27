class LoginState<T> {
  final bool loading;
  final T? success;
  final String? error;

  LoginState({this.loading = false, this.success, this.error});
}

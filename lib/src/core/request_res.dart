class RequestRes {
  dynamic response;
  ErrorRes? error;

  RequestRes({this.response, this.error});

  bool hasError() => error != null;
}

class ErrorRes {
  String message;
  dynamic code;
  dynamic data;

  ErrorRes({
    required this.message,
    this.data,
    this.code,
  });

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "data": data,
      };
}

class MyResponse<T> {
  final int statusCode;
  final String statusMessage;
  final T? data;

  MyResponse(
      {required this.statusCode,
      required this.statusMessage,
      required this.data,
      int? status,
      String? message});
}

class ErrorResponse {
  final bool error;
  final String message;

  ErrorResponse({
    required this.error,
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      error: json['error'],
      message: json['message'],
    );
  }
}

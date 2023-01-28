class ApiResponse<T extends Object> {
  final bool hasError;
  final T? data;
  final String? message;

  ApiResponse({
    required this.hasError,
    required this.data,
    required this.message,
  });
}

class ResponseBaseModel<T> {
  bool? success;
  String? message;
  T? body;

  ResponseBaseModel({
    this.success,
    this.message,
    this.body,
  });

  factory ResponseBaseModel.fromJson(Map<String, dynamic> json) {
    return ResponseBaseModel<T>(
      success: json["success"]?? false,
      message: json["message"] ??"",
      body: json["body"],
    );
  }
}

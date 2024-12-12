import '../utils/model_keys.dart';

class BaseResponse {
  String? message;
  bool? status;

  BaseResponse({this.message, this.status});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      message: json[CommonKeys.message],
      status: json[CommonKeys.status],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[CommonKeys.message] = this.message;
    data[CommonKeys.status] = this.status;
    return data;
  }
}

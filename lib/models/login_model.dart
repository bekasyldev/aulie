import 'package:granth_flutter/utils/model_keys.dart';

class LoginResponse {
  UserData? data;
  String? message;

  LoginResponse({this.data, this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      data: json[CommonKeys.data] != null ? UserData.fromJson(json[CommonKeys.data]) : null,
      message: json[CommonKeys.message] != null ? json[CommonKeys.message] : "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data[CommonKeys.data] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? activationToken;
  String? apiToken;
  String? contactNumber;
  String? createdAt;
  String? deletedAt;
  String? deviceId;
  String? email;
  DateTime? emailVerifiedAt;
  int? id;
  String? image;
  String? name;
  String? registrationId;
  String? status;
  String? updatedAt;
  String? userType;
  String? userName;

  UserData(
      {this.activationToken,
      this.apiToken,
      this.contactNumber,
      this.createdAt,
      this.deletedAt,
      this.deviceId,
      this.email,
      this.emailVerifiedAt,
      this.id,
      this.image,
      this.name,
      this.registrationId,
      this.status,
      this.updatedAt,
      this.userType,
      this.userName});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      activationToken: json[UserKeys.activationToken] != null ? json[UserKeys.activationToken] : null,
      apiToken: json[UserKeys.apiToken],
      contactNumber: json[UserKeys.contactNumber],
      createdAt: json[UserKeys.createdAt],
      deletedAt: json[CommonKeys.deletedAt] != null ? json[CommonKeys.deletedAt] : null,
      deviceId: json[UserKeys.deviceId] != null ? json[UserKeys.deviceId] : null,
      email: json[UserKeys.email],
      emailVerifiedAt: json[UserKeys.emailVerifiedAt] != null ? json[UserKeys.emailVerifiedAt] : null,
      id: json[UserKeys.id],
      image: json[UserKeys.image],
      name: json[UserKeys.name],
      registrationId: json[UserKeys.registrationId],
      status: json[UserKeys.status],
      updatedAt: json[CommonKeys.updatedAt],
      userType: json[UserKeys.userType],
      userName: json[UserKeys.userName],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[UserKeys.apiToken] = this.apiToken;
    data[UserKeys.contactNumber] = this.contactNumber;
    data[UserKeys.createdAt] = this.createdAt;
    data[UserKeys.email] = this.email;
    data[UserKeys.id] = this.id;
    data[UserKeys.image] = this.image;
    data[UserKeys.name] = this.name;
    data[UserKeys.registrationId] = this.registrationId;
    data[UserKeys.status] = this.status;
    data[CommonKeys.updatedAt] = this.updatedAt;
    data[UserKeys.userType] = this.userType;
    data[UserKeys.userName] = this.userName;
    if (this.activationToken != null) {
      data[UserKeys.activationToken] = this.activationToken!;
    }
    if (this.deletedAt != null) {
      data[CommonKeys.deletedAt] = this.deletedAt;
    }
    if (this.deviceId != null) {
      data[UserKeys.deviceId] = this.deviceId;
    }
    if (this.emailVerifiedAt != null) {
      data[UserKeys.emailVerifiedAt] = this.emailVerifiedAt;
    }
    return data;
  }
}

class ErrorResponse {
  ErrorData? error;

  ErrorResponse({this.error});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      error: json[CommonKeys.error] != null ? ErrorData.fromJson(json[CommonKeys.error]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.error != null) {
      data[CommonKeys.error] = this.error!.toJson();
    }
    return data;
  }
}

class ErrorData {
  List<dynamic>? message;

  ErrorData({this.message});

  factory ErrorData.fromJson(Map<String, dynamic> json) {
    return ErrorData(
      message: json[CommonKeys.message] != null ? new List<String>.from(json[CommonKeys.message]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data[CommonKeys.message] = this.message;
    }
    return data;
  }
}

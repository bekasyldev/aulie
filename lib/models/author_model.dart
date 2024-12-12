import 'package:granth_flutter/utils/model_keys.dart';

class AuthorResponse {
  String? address;
  int? authorId;
  String? description;
  String? designation;
  String? education;
  String? emailId;
  String? image;
  String? mobileNo;
  String? name;
  String? status;

  AuthorResponse({this.address, this.authorId, this.description, this.designation, this.education, this.emailId, this.image, this.mobileNo, this.name, this.status});

  factory AuthorResponse.fromJson(Map<String, dynamic> json) {
    return AuthorResponse(
      address: json[DashboardKeys.address],
      authorId: json[DashboardKeys.authorId],
      description: json[DashboardKeys.description],
      designation: json[DashboardKeys.designation],
      education: json[DashboardKeys.education],
      emailId: json[DashboardKeys.emailId] != null ? json[DashboardKeys.emailId] : null,
      image: json[UserKeys.image],
      mobileNo: json[DashboardKeys.mobileNo] != null ? json[DashboardKeys.mobileNo] : null,
      name: json[UserKeys.name],
      status: json[CommonKeys.status],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[DashboardKeys.address] = this.address;
    data[DashboardKeys.authorId] = this.authorId;
    data[DashboardKeys.description] = this.description;
    data[DashboardKeys.designation] = this.designation;
    data[DashboardKeys.education] = this.education;
    data[UserKeys.image] = this.image;
    data[UserKeys.name] = this.name;
    data[CommonKeys.status] = this.status;
    if (this.emailId != null) {
      data[DashboardKeys.emailId] = this.emailId;
    }
    if (this.mobileNo != null) {
      data[DashboardKeys.mobileNo] = this.mobileNo;
    }
    return data;
  }
}

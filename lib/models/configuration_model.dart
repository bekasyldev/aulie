import 'package:granth_flutter/utils/model_keys.dart';

class ConfigurationResponse {
  String? createdAt;
  int? id;
  String? key;
  String? updatedAt;
  String? value;

  ConfigurationResponse({this.createdAt, this.id, this.key, this.updatedAt, this.value});

  factory ConfigurationResponse.fromJson(Map<String, dynamic> json) {
    return ConfigurationResponse(
      createdAt: json[CommonKeys.createdAt] != null ? json[CommonKeys.createdAt] : null,
      id: json[DashboardKeys.id],
      key: json[DashboardKeys.key],
      updatedAt: json[CommonKeys.updatedAt] != null ? json[CommonKeys.updatedAt] : null,
      value: json[DashboardKeys.value],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[DashboardKeys.id] = this.id;
    data[DashboardKeys.key] = this.key;
    data[DashboardKeys.value] = this.value;
    if (this.createdAt != null) {
      data[CommonKeys.createdAt] = this.createdAt;
    }
    if (this.updatedAt != null) {
      data[CommonKeys.updatedAt] = this.updatedAt;
    }
    return data;
  }
}

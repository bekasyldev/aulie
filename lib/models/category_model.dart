import 'package:granth_flutter/utils/model_keys.dart';

class CategoryBookResponse {
  int? categoryId;
  int? subCategoryId;
  String? createdAt;
  String? deletedAt;
  String? categoryName;
  String? status;
  String? updatedAt;

  CategoryBookResponse({this.categoryId, this.createdAt, this.deletedAt, this.categoryName, this.status, this.updatedAt, this.subCategoryId});

  factory CategoryBookResponse.fromJson(Map<String, dynamic> json) {
    return CategoryBookResponse(
      categoryId: json[DashboardKeys.categoryId],
      createdAt: json[CommonKeys.createdAt],
      deletedAt: json[CommonKeys.deletedAt] != null ? json[CommonKeys.deletedAt] : null,
      categoryName: json[UserKeys.name],
      status: json[CommonKeys.status],
      updatedAt: json[CommonKeys.updatedAt],
      subCategoryId: json[AllBookDetailsKey.subCategoryId],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[DashboardKeys.categoryId] = this.categoryId;
    data[CommonKeys.createdAt] = this.createdAt;
    data[UserKeys.name] = this.categoryName;
    data[CommonKeys.status] = this.status;
    data[CommonKeys.updatedAt] = this.updatedAt;
    if (this.deletedAt != null) {
      data[CommonKeys.deletedAt] = this.deletedAt!;
    }
    data[AllBookDetailsKey.subCategoryId] = this.subCategoryId;
    return data;
  }
}

class SubCategoryResponse {
  List<CategoryBookResponse>? data;

  SubCategoryResponse({this.data});

  factory SubCategoryResponse.fromJson(Map<String, dynamic> json) {
    return SubCategoryResponse(
      data: json[CommonKeys.data] != null ? (json[CommonKeys.data] as List).map((i) => CategoryBookResponse.fromJson(i)).toList() : null,
    );
  }
}

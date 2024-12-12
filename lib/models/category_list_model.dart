import 'package:granth_flutter/models/pagination_model.dart';

class CategoryListModel {
  List<Category>? data;
  Pagination? pagination;

  CategoryListModel({this.data, this.pagination});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    return CategoryListModel(
      data: json['data'] != null ? (json['data'] as List).map((i) => Category.fromJson(i)).toList() : null,
      pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Category {
  int? categoryId;
  String? name;
  String? status;
  int? totalBook;

  Category({this.categoryId, this.name, this.status, this.totalBook});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'],
      name: json['name'],
      status: json['status'],
      totalBook: json['total_book'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['total_book'] = this.totalBook;
    return data;
  }
}

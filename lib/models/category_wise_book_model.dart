import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/models/pagination_model.dart';
import 'package:granth_flutter/utils/model_keys.dart';

class CategoryWiseBookModel {
  List<BookDetailResponse>? data;
  var maxPrice;
  Pagination? pagination;

  CategoryWiseBookModel({this.data, this.maxPrice, this.pagination});

  factory CategoryWiseBookModel.fromJson(Map<String, dynamic> json) {
    return CategoryWiseBookModel(
      data: json[CommonKeys.data] != null ? (json[CommonKeys.data] as List).map((i) => BookDetailResponse.fromJson(i)).toList() : null,
      maxPrice: json[CategoryWiseBook.maxPrice],
      pagination: json[CommonKeys.pagination] != null ? Pagination.fromJson(json[CommonKeys.pagination]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[CategoryWiseBook.maxPrice] = this.maxPrice;
    if (this.data != null) {
      data[CommonKeys.data] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data[CommonKeys.pagination] = this.pagination!.toJson();
    }
    return data;
  }
}

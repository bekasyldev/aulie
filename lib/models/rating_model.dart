import 'package:granth_flutter/models/book_ratting_list_model.dart';
import 'package:granth_flutter/utils/model_keys.dart';

class RatingModel {
  List<BookRatingData>? data;

  RatingModel({this.data});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      data: json[CommonKeys.data] != null ? (json[CommonKeys.data] as List).map((i) => BookRatingData.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data[CommonKeys.data] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

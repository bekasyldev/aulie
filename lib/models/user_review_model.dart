import 'package:granth_flutter/utils/model_keys.dart';

class UserReviewData {
  int? ratingId;
  int? bookId;
  int? userId;
  int? rating;
  String? review;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  UserReviewData({this.ratingId, this.bookId, this.userId, this.rating, this.review, this.deletedAt, this.createdAt, this.updatedAt});

  UserReviewData.fromJson(Map<String, dynamic> json) {
    ratingId = json[BookRatingDataKey.ratingId];
    bookId = json[CommonKeys.bookId];
    userId = json[BookRatingDataKey.userid];
    rating = json[BookRatingDataKey.rating];
    review = json[BookRatingDataKey.review];
    deletedAt = json[CommonKeys.deletedAt];
    createdAt = json[CommonKeys.createdAt];
    updatedAt = json[CommonKeys.updatedAt];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[BookRatingDataKey.ratingId] = this.ratingId;
    data[CommonKeys.bookId] = this.bookId;
    data[BookRatingDataKey.userid] = this.userId;
    data[BookRatingDataKey.rating] = this.rating;
    data[BookRatingDataKey.review] = this.review;
    data[CommonKeys.deletedAt] = this.deletedAt;
    data[CommonKeys.createdAt] = this.createdAt;
    data[CommonKeys.updatedAt] = this.updatedAt;
    return data;
  }
}

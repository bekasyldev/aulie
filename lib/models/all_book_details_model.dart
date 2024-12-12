import 'package:granth_flutter/models/user_review_model.dart';
import 'package:granth_flutter/utils/model_keys.dart';

import 'author_model.dart';
import 'book_ratting_list_model.dart';
import 'bookdetail_model.dart';

class AllBookDetailsModel {
  List<BookDetailResponse>? authorBookList;
  List<AuthorResponse>? authorDetail;
  List<BookDetailResponse>? bookDetailResponse;
  List<BookRatingData>? bookRatingData;
  List<BookDetailResponse>? recommendedBook;
  UserReviewData? userReviewData;

  AllBookDetailsModel({this.bookDetailResponse, this.authorDetail, this.recommendedBook, this.bookRatingData, this.authorBookList, this.userReviewData});

  factory AllBookDetailsModel.fromJson(Map<String, dynamic> json) {
    return AllBookDetailsModel(
      authorBookList: json[AllBookDetailsKey.authorBookList] != null ? (json[AllBookDetailsKey.authorBookList] as List).map((i) => BookDetailResponse.fromJson(i)).toList() : null,
      authorDetail: json[AllBookDetailsKey.authorDetail] != null ? (json[AllBookDetailsKey.authorDetail] as List).map((i) => AuthorResponse.fromJson(i)).toList() : null,
      bookDetailResponse: json[AllBookDetailsKey.bookDetail] != null ? (json[AllBookDetailsKey.bookDetail] as List).map((i) => BookDetailResponse.fromJson(i)).toList() : null,
      bookRatingData: json[AllBookDetailsKey.bookRatingData] != null ? (json[AllBookDetailsKey.bookRatingData] as List).map((i) => BookRatingData.fromJson(i)).toList() : null,
      recommendedBook: json[AllBookDetailsKey.recommendedBook] != null ? (json[AllBookDetailsKey.recommendedBook] as List).map((i) => BookDetailResponse.fromJson(i)).toList() : null,
      userReviewData: json[AllBookDetailsKey.userReviewData] != null ? UserReviewData.fromJson(json[AllBookDetailsKey.userReviewData]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.authorBookList != null) {
      data[AllBookDetailsKey.authorBookList] = this.authorBookList!.map((v) => v.toJson()).toList();
    }
    if (this.authorDetail != null) {
      data[AllBookDetailsKey.authorDetail] = this.authorDetail!.map((v) => v.toJson()).toList();
    }
    if (this.bookDetailResponse != null) {
      data[AllBookDetailsKey.bookDetail] = this.bookDetailResponse!.map((v) => v.toJson()).toList();
    }
    if (this.bookRatingData != null) {
      data[AllBookDetailsKey.bookRatingData] = this.bookRatingData!.map((v) => v.toJson()).toList();
    }
    if (this.recommendedBook != null) {
      data[AllBookDetailsKey.recommendedBook] = this.recommendedBook!.map((v) => v.toJson()).toList();
    }
    if (this.userReviewData != null) {
      data[AllBookDetailsKey.userReviewData] = this.userReviewData!.toJson();
    }
    return data;
  }
}

import 'package:granth_flutter/utils/model_keys.dart';

class BookDetailResponse {
  String? authorName;
  String? backCover;
  int? bookId;
  String? categoryName;
  String? dateOfPublication;
  String? description;
  num? discount;
  num? discountedPrice;
  String? edition;
  String? filePath;
  String? fileSamplePath;
  String? format;
  String? frontCover;
  int? isWishlist;
  String? keywords;
  String? language;
  String? name;
  num? price;
  String? publisher;
  String? subcategoryName;
  String? title;
  String? topicCover;
  num? review;
  num? totalRating;
  num? totalPage;
  num? isPurchase;

  BookDetailResponse({
    this.authorName,
    this.backCover,
    this.bookId,
    this.categoryName,
    this.dateOfPublication,
    this.description,
    this.discount,
    this.discountedPrice,
    this.edition,
    this.filePath,
    this.fileSamplePath,
    this.format,
    this.frontCover,
    this.isWishlist,
    this.keywords,
    this.language,
    this.name,
    this.price,
    this.publisher,
    this.subcategoryName,
    this.title,
    this.topicCover,
    this.review,
    this.totalRating,
    this.totalPage,
    this.isPurchase,
  });

  factory BookDetailResponse.fromJson(Map<String, dynamic> json) {
    return BookDetailResponse(
      authorName: json[DashboardKeys.authorName],
      backCover: json[DashboardKeys.backCover] != null ? json[DashboardKeys.backCover] : null,
      bookId: json[CommonKeys.bookId],
      categoryName: json[DashboardKeys.categoryName],
      dateOfPublication: json[DashboardKeys.dateOfPublication],
      description: json[DashboardKeys.description],
      discount: json[DashboardKeys.discount],
      discountedPrice: json[DashboardKeys.discountedPrice],
      edition: json[DashboardKeys.edition] != null ? json[DashboardKeys.edition] : null,
      filePath: json[DashboardKeys.filePath],
      fileSamplePath: json[DashboardKeys.filePath],
      format: json[DashboardKeys.format],
      frontCover: json[DashboardKeys.frontCover],
      isWishlist: json[DashboardKeys.isWishlist] != null ? json[DashboardKeys.isWishlist] : null,
      keywords: json[DashboardKeys.keywords],
      language: json[DashboardKeys.language],
      name: json[UserKeys.name],
      price: json[DashboardKeys.price],
      publisher: json[DashboardKeys.publisher],
      subcategoryName: json[DashboardKeys.subcategoryName],
      title: json[DashboardKeys.title],
      topicCover: json[DashboardKeys.topicCover] != null ? json[DashboardKeys.topicCover] : null,
      review: json[BookRatingDataKey.totalReview],
      totalRating: json[BookRatingDataKey.totalRating],
      totalPage: json[BookRatingDataKey.pageCount],
      isPurchase: json[BookRatingDataKey.isPurchase],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[DashboardKeys.authorName] = this.authorName;
    data[CommonKeys.bookId] = this.bookId;
    data[DashboardKeys.categoryName] = this.categoryName;
    data[DashboardKeys.dateOfPublication] = this.dateOfPublication;
    data[DashboardKeys.description] = this.description;
    data[DashboardKeys.discount] = this.discount;
    data[DashboardKeys.discountedPrice] = this.discountedPrice;
    data[DashboardKeys.filePath] = this.filePath;
    data[DashboardKeys.filePath] = this.fileSamplePath;
    data[DashboardKeys.format] = this.format;
    data[DashboardKeys.frontCover] = this.frontCover;
    data[DashboardKeys.keywords] = this.keywords;
    data[DashboardKeys.language] = this.language;
    data[UserKeys.name] = this.name;
    data[DashboardKeys.price] = this.price;
    data[DashboardKeys.publisher] = this.publisher;
    data[DashboardKeys.subcategoryName] = this.subcategoryName;
    data[DashboardKeys.title] = this.title;
    data[BookRatingDataKey.totalReview] = this.review;
    data[BookRatingDataKey.totalRating] = this.totalRating;
    data[BookRatingDataKey.pageCount] = this.totalPage;
    data[BookRatingDataKey.isPurchase] = this.isPurchase;
    if (this.backCover != null) {
      data[DashboardKeys.backCover] = this.backCover!;
    }
    if (this.edition != null) {
      data[DashboardKeys.edition] = this.edition;
    }
    if (this.isWishlist != null) {
      data[DashboardKeys.isWishlist] = this.isWishlist;
    }
    if (this.topicCover != null) {
      data[DashboardKeys.topicCover] = this.topicCover;
    }
    return data;
  }
}

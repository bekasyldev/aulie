import '../utils/model_keys.dart';

class BookRatingData {
  String? createdAt;
  String? profileImage;
  num? rating;
  num? ratingId;
  String? review;
  num? userId;
  String? userName;

  BookRatingData({this.createdAt, this.profileImage, this.rating, this.ratingId, this.review, this.userId, this.userName});

  factory BookRatingData.fromJson(Map<String, dynamic> json) {
    return BookRatingData(
      createdAt: json[CommonKeys.createdAt],
      profileImage: json[BookRatingDataKey.profileImage],
      rating: json[BookRatingDataKey.rating],
      ratingId: json[BookRatingDataKey.ratingId],
      review: json[BookRatingDataKey.review],
      userId: json[BookRatingDataKey.userid],
      userName: json[BookRatingDataKey.username],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[CommonKeys.createdAt] = this.createdAt;
    data[BookRatingDataKey.profileImage] = this.profileImage;
    data[BookRatingDataKey.rating] = this.rating;
    data[BookRatingDataKey.ratingId] = this.ratingId;
    data[BookRatingDataKey.review] = this.review;
    data["user_id"] = this.userId;
    data[BookRatingDataKey.username] = this.userName;
    return data;
  }
}

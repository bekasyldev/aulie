import '../utils/model_keys.dart';

class CartResponse {
  List<CartModel>? data;

  CartResponse({this.data});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      data: json[CommonKeys.data] != null ? (json[CommonKeys.data] as List).map((i) => CartModel.fromJson(i)).toList() : null,
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

class CartModel {
  String? authorName;
  int? bookId;
  int? cartMappingId;
  num? discount;
  num? discountedPrice;
  String? frontCover;
  String? name;
  num? price;
  String? title;
  int? paymentType;

  CartModel({this.authorName, this.bookId, this.cartMappingId, this.discount, this.discountedPrice, this.frontCover, this.name, this.price, this.title, this.paymentType});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        authorName: json[CartModelKey.authorName],
        bookId: json[CommonKeys.bookId],
        cartMappingId: json[CartModelKey.cartMappingId],
        discount: json[CartModelKey.discount],
        discountedPrice: json[CartModelKey.discountedPrice],
        frontCover: json[CartModelKey.frontCover],
        name: json[CartModelKey.name],
        price: json[CartModelKey.price],
        title: json[CartModelKey.title],
        paymentType: json[CartModelKey.paymentType]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[CartModelKey.authorName] = this.authorName;
    data[CommonKeys.bookId] = this.bookId;
    data[CartModelKey.cartMappingId] = this.cartMappingId;
    data[CartModelKey.discount] = this.discount;
    data[CartModelKey.discountedPrice] = this.discountedPrice;
    data[CartModelKey.frontCover] = this.frontCover;
    data[CartModelKey.name] = this.name;
    data[CartModelKey.price] = this.price;
    data[CartModelKey.title] = this.title;
    data[CartModelKey.paymentType] = this.paymentType;
    return data;
  }
}

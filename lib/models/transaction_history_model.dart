import 'dart:convert';

import 'package:granth_flutter/models/order_details_model.dart';
import 'package:granth_flutter/utils/model_keys.dart';

class TransactionHistoryResponse {
  List<Transaction>? transactionData;

  TransactionHistoryResponse({this.transactionData});

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryResponse(
      transactionData: json[CommonKeys.data] != null ? (json[CommonKeys.data] as List).map((i) => Transaction.fromJson(i)).toList() : null,
    );
  }
}

class Transaction {
  int? bookId;
  String? bookName;
  String? bookTitle;
  String? frontCover;
  num? price;
  int? discount;
  num? totalAmount;
  int? paymentType;
  String? txnId;
  String? paymentStatus;
  String? datetime;
  OtherDetailResponse? otherTransactionDetail;

  Transaction({
    this.bookId,
    this.bookName,
    this.bookTitle,
    this.frontCover,
    this.price,
    this.discount,
    this.totalAmount,
    this.paymentType,
    this.txnId,
    this.paymentStatus,
    this.otherTransactionDetail,
    this.datetime,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      bookId: json[CommonKeys.bookId],
      bookName: json[TransactionKeys.bookName],
      bookTitle: json[TransactionKeys.bookTitle],
      frontCover: json[TransactionKeys.frontCover] != null ? json[TransactionKeys.frontCover] : null,
      price: json[TransactionKeys.price],
      discount: json[TransactionKeys.discount],
      totalAmount: json[TransactionKeys.totalAmount],
      paymentType: json[TransactionKeys.paymentType],
      txnId: json[TransactionKeys.txnId],
      paymentStatus: json[TransactionKeys.paymentStatus],
      datetime: json["datetime"],
      otherTransactionDetail: json[TransactionKeys.otherTransactionDetail] != null ? OtherDetailResponse.fromJson(jsonDecode(json[TransactionKeys.otherTransactionDetail])) : null,
    );
  }
}

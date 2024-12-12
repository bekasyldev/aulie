import 'package:granth_flutter/utils/model_keys.dart';

class OtherDetailResponse {
  String? bankName;
  String? txnOrderId;
  String? txnAmount;
  String? txnDate;
  String? mID;
  String? txnIds;
  String? paymentMode;
  String? currency;
  String? bankTxnId;
  String? gatewayName;
  String? respMessage;
  String? status;
  String? txtPaymentId;

  OtherDetailResponse({
    this.bankName,
    this.txnOrderId,
    this.txnAmount,
    this.txnDate,
    this.mID,
    this.txnIds,
    this.paymentMode,
    this.currency,
    this.bankTxnId,
    this.gatewayName,
    this.respMessage,
    this.status,
    this.txtPaymentId,
  });

  factory OtherDetailResponse.fromJson(Map<String, dynamic> json) {
    return OtherDetailResponse(
      bankName: json[TransactionKeys.bankName],
      txnOrderId: json[TransactionKeys.txnOrderId],
      txnAmount: json[TransactionKeys.txnAmount],
      txnDate: json[TransactionKeys.txnDate],
      mID: json[TransactionKeys.mID],
      txnIds: json[TransactionKeys.txnIds],
      paymentMode: json[TransactionKeys.paymentMode],
      currency: json[TransactionKeys.currency],
      bankTxnId: json[TransactionKeys.bankTxnId],
      gatewayName: json[TransactionKeys.gatewayName],
      respMessage: json[TransactionKeys.respMessage],
      status: json[TransactionKeys.status],
      txtPaymentId: json[TransactionKeys.txtPaymentId],
    );
  }
}

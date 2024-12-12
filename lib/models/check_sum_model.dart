import 'package:granth_flutter/utils/model_keys.dart';

class CheckSumModel {
  CheckSum? data;

  CheckSumModel({this.data});

  factory CheckSumModel.fromJson(Map<String, dynamic> json) {
    return CheckSumModel(
      data: json[CommonKeys.data] != null ? CheckSum.fromJson(json[CommonKeys.data]) : null,
    );
  }
}

class CheckSum {
  OrderData? orderData;
  ChecksumData? checksumData;

  CheckSum({this.orderData, this.checksumData});

  factory CheckSum.fromJson(Map<String, dynamic> json) {
    return CheckSum(
      orderData: json[CheckSumKey.orderData] != null ? OrderData.fromJson(json[CheckSumKey.orderData]) : null,
      checksumData: json[CheckSumKey.checkSumData] != null ? ChecksumData.fromJson(json[CheckSumKey.checkSumData]) : null,
    );
  }
}

class ChecksumData {
  var checkSumHash;
  var orderId;
  var payStatus;

  ChecksumData({this.checkSumHash, this.orderId, this.payStatus});

  factory ChecksumData.fromJson(Map<String, dynamic> json) {
    return ChecksumData(
      checkSumHash: json['CHECKSUMHASH'],
      orderId: json['ORDER_ID'],
      payStatus: json['PAYT_STATUS'],
    );
  }
}

class OrderData {
  var mID;
  var orderId;
  var custId;
  var industryTypeId;
  var channelId;
  var txnAmount;
  var callBackUrl;
  var website;
  var eMAIL;
  var mobileNo;

  OrderData({this.mID, this.orderId, this.custId, this.industryTypeId, this.channelId, this.txnAmount, this.callBackUrl, this.website, this.eMAIL, this.mobileNo});

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      mID: json['MID'],
      orderId: json['ORDER_ID'],
      custId: json['CUST_ID'],
      industryTypeId: json['INDUSTRY_TYPE_ID'],
      channelId: json['CHANNEL_ID'],
      txnAmount: json['TXN_AMOUNT'],
      callBackUrl: json['CALLBACK_URL'],
      website: json['WEBSITE'],
      eMAIL: json['EMAIL'],
      mobileNo: json['MOBILE_NO'],
    );
  }
}

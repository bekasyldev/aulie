import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/cart_response.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayPayment {
  static Razorpay? razorPay;
  static List<CartModel>? cartResponse;

  // static late OrderDetailModel orderDetail;
  static String? appName;
  static double? total;

  static init({required appData, required totalAmount, required List<CartModel> cartData}) {
    cartResponse = cartData;

    appName = appData;
    total = totalAmount;
    razorPay = Razorpay();
    razorPay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, RazorPayPayment.handlePaymentSuccess);
    razorPay!.on(Razorpay.EVENT_PAYMENT_ERROR, RazorPayPayment.handlePaymentError);
    razorPay!.on(Razorpay.EVENT_EXTERNAL_WALLET, RazorPayPayment.handleExternalWallet);
  }

  static void handlePaymentSuccess(PaymentSuccessResponse response) async {
    var request = <String, String?>{
      "TXNID": response.paymentId,
      "STATUS": "TXN_SUCCESS",
      "TXN_PAYMENT_ID": response.paymentId,
      "TXN_ORDER_ID": response.orderId.toString().isEmptyOrNull ? response.paymentId.toString() : response.orderId.toString(),
      "TXN_signature": response.signature,
    };
    var data = jsonEncode(cartResponse);
    saveTransaction(request, data, RAZOR_PAY_STATUS, 'TXN_SUCCESS', total);
  }

  static void handlePaymentError(PaymentFailureResponse response) {
    toast("Error: " + response.code.toString() + " - " + response.message!, print: true);
  }

  static void handleExternalWallet(ExternalWalletResponse response) {
    toast("external_wallet: " + response.walletName!);
  }

  static void razorPayCheckout(num mAmount) async {
    String username = RAZOR_KEY;
    String password = RAZORPAY_KEY_SECRET;
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var headers = {HttpHeaders.authorizationHeader: basicAuth, HttpHeaders.contentTypeHeader: 'application/json'};
    var request = http.Request('POST', Uri.parse(RAZOR_PAY_URL));
    request.body = json.encode({
      "amount": '${(total.validate() * 100).toInt()}',
      "receipt": "receipt#1",
    });
    request.headers.addAll(headers);
    var options = {
      'key': RAZOR_KEY,
      'amount': (total.validate() * 100).toInt(),
      'name': appName,
      'theme.color': '#e87219',
      'description': appName,
      'image': 'https://razorpay.com/assets/razorpay-glyph.svg',
      'prefill': {'contact': appStore.userContactNumber.validate(), 'email': appStore.userEmail.validate()},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorPay!.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/cart_response.dart';
import 'package:granth_flutter/models/stripe_model.dart';
import 'package:granth_flutter/network/network_utils.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

class StripeServices {
  static List<CartModel>? cartResponse;
  num totalAmount = 0;
  String stripeURL = "";
  String stripePaymentKey = "";
  bool isTest = false;

  init({
    required String stripePaymentPublishKey,
    required List<CartModel> data,
    required num totalAmount,
    required String stripeURL,
    required String stripePaymentKey,
    required bool isTest,
  }) async {
    Stripe.publishableKey = STRIPE_PAYMENT_PUBLISH_KEY;
    Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';

    await Stripe.instance.applySettings().catchError((e) {
      toast(e.toString(), print: true);

      throw e.toString();
    });

    cartResponse = data;
    this.totalAmount = appStore.payableAmount;
    this.stripeURL = stripeURL;
    this.stripePaymentKey = stripePaymentKey;
    setValue("StripeKeyPayment", stripePaymentKey);
  }

  //StripPayment
  void stripePay() async {
    Map<String, String> headers = {
      HttpHeaders.authorizationHeader: 'Bearer $stripePaymentKey',
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded',
    };

    var request = Request('POST', Uri.parse(stripeURL));

    request.bodyFields = {
      'amount': '500',
      'currency': 'INR',
    };

    log(request.bodyFields);
    request.headers.addAll(headers);

    appStore.setLoading(true);

    await request.send().then((value) {
      appStore.setLoading(false);

      Response.fromStream(value).then((response) async {
        if (response.statusCode.isSuccessful()) {
          StripePayModel res = StripePayModel.fromJson(await handleResponse(response));

          await Stripe.instance
              .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
                paymentIntentClientSecret: res.client_secret.validate(),
                merchantDisplayName: APP_NAME,
                customerId: appStore.userId.toString(),
                customerEphemeralKeySecret: isAndroid ? res.client_secret.validate() : null,
                setupIntentClientSecret: res.client_secret.validate()),
          )
              .then((value) async {
            await Stripe.instance.presentPaymentSheet().then((value) async {
              Stripe.instance.retrievePaymentIntent(res.client_secret.validate()).then((vs) {
                toast("${vs.toJson()}", print: true);
                var request = <String, String?>{
                  "TXNID": vs.id.toString(),
                  "STATUS": "TXN_SUCCESS",
                  "TXN_PAYMENT_ID": vs.paymentMethodId,
                  "TXN_ORDER_ID": vs.id.toString().isEmptyOrNull ? vs.paymentMethodId.toString() : vs.id.toString(),
                };
                var data = jsonEncode(cartResponse);
                saveTransaction(request, data, STRIPE_STATUS, 'TXN_SUCCESS', totalAmount);
              }).catchError((e) {
                toast(e.toString(), print: true);
              });
            }).catchError((e) {
              log("presentPaymentSheet ${e.toString()}");
            });
          }).catchError((e) {
            toast(e.toString(), print: true);

            throw e.toString();
          });
        } else if (response.statusCode == 400) {
          toast("Testing Credential cannot pay more than 500");
        }
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString(), print: true);

        throw e.toString();
      });
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);

      throw e.toString();
    });
  }
}

StripeServices stripeServices = StripeServices();

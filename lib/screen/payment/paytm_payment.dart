/*
import 'dart:convert';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:paytm/paytm.dart';

import '../main.dart';
import '../models/check_sum_model.dart';
import '../network/rest_apis.dart';
import '../utils/configs.dart';
import '../utils/constants.dart';

class PaytmPayment extends StatefulWidget {
  const PaytmPayment({Key? key}) : super(key: key);

  @override
  State<PaytmPayment> createState() => _PaytmPaymentState();
}

class _PaytmPaymentState extends State<PaytmPayment> {
  String paymentResponse = "";

  checkSumApi({double? total}) {
    var request = {
      "TXN_AMOUNT": total.toString(),
      "EMAIL": 'test@gmail.com',
      "MOBILE_NO": '000000000',
    };

    getChecksum(request).then((result) async {
      CheckSumModel checksum = CheckSumModel.fromJson(result);
      String cusId = checksum.data!.order_data!.cUST_ID.toString();
      await paytmPayment(paymentMethod: PAYTM, total: total, orderId: checksum.data!.order_data!.oRDER_ID.toString(), cusId: cusId);
    }).catchError((error) {
      toast(error.toString());
    });
  }

  paytmPayment({String? paymentMethod, String? orderId, double? total, String? cusId}) async {
    appStore.setLoading(true);
    String callBackUrl = (testing ? 'https://securegw-stage.paytm.in' : 'https://securegw.paytm.in') + '/theia/paytmCallback?ORDER_ID=' + orderId.toString();

    var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

    var body = json.encode(
        {"mid": PAYTM_ID, "key_secret": PAYTM_SECRET_KEY, "website": false, "orderId": orderId, "amount": total.toString(), "callbackUrl": callBackUrl, "custId": cusId, "testing": testing ? 0 : 1});

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': "application/json"},
      );
      String txnToken = response.body;

      var paytmResponse = Paytm.payWithPaytm(mId: PAYTM_ID, orderId: orderId.toString(), txnToken: txnToken, txnAmount: "1", callBackUrl: callBackUrl, staging: testing, appInvokeEnabled: false);

      paytmResponse.then((value) {
        print(value);
        setState(() {
          appStore.setLoading(false);
          if (value['error']) {
            paymentResponse = value['errorMessage'];
          } else {
            if (value['response'] != null) {
              paymentResponse = value['response']['STATUS'];
              print("paytm success${paymentResponse.toString()}");
              var request = <String, String?>{
                "TXNID": value['response']['TXNID'],
                "STATUS": value['response']['STATUS'],
                "TXN_ORDER_ID": value['response']['ORDERID'],
                "TXN_BANK_NAME": value['response']['BANKNAME:WALLET'],
              };
              //    saveTransaction(request, getOrderDetail(paymentType: PAYTM_STATUS), PAYTM, 'TXN_SUCCESS');
            }
          }
          paymentResponse += "\n" + value.toString();
        });
      });
    } catch (e) {
      appStore.setLoading(false);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
*/
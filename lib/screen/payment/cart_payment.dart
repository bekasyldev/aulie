import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/cart_response.dart';
import 'package:granth_flutter/screen/payment/razor_pay_payment.dart';
import 'package:granth_flutter/screen/payment/stripe_payment.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/utils/constants.dart';

import 'package:nb_utils/nb_utils.dart';

class CartPayment {
  StripeServices stripeServices = StripeServices();
  bool isDisabled = false;

  Future<void> placeOrder({required String paymentMode, required List<CartModel> cartItemList, BuildContext? context}) async {
    if (paymentMode.isNotEmpty) {
      if (paymentMode == RAZOR_PAY) {
        appStore.setLoading(true);
        RazorPayPayment.init(appData: APP_NAME, totalAmount: appStore.payableAmount, cartData: cartItemList);

        await 1.seconds.delay;
        appStore.setLoading(false);
        RazorPayPayment.razorPayCheckout(appStore.payableAmount);
      }
      /*else if (paymentMode == PAYTM) {
        PaytmPayment().checkSumApi(total: appStore.payableAmount);
      } */
      else if (paymentMode == STRIPE) {
        stripeServices.init(
          stripePaymentPublishKey: STRIPE_PAYMENT_KEY,
          data: cartItemList,
          totalAmount: appStore.payableAmount,
          stripeURL: STRIPE_URL,
          stripePaymentKey: STRIPE_PAYMENT_KEY,
          isTest: true,
        );
        await 1.seconds.delay;
        stripeServices.stripePay();
      }
    } else {
      toast("Payment option are not selected");
    }
  }
}

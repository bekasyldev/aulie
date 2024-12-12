import 'package:flutter/material.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:flutterwave_standard/models/requests/customer.dart';
import 'package:flutterwave_standard/models/requests/customizations.dart';
import 'package:granth_flutter/main.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../configs.dart';
import '../../network/rest_apis.dart';

class FlutterWave {
  bool isDisabled = false;

  Future<void> flutterWaveCheckout({
    required BuildContext ctx,
    required Function(ChargeResponse) onCompleteCall,
  }) async {
    if (isDisabled) return;

    final Customer customer = Customer(
      name: appStore.userName,
      phoneNumber: appStore.userContactNumber,
      email: appStore.userEmail,
    );
    Flutterwave flutterWave = Flutterwave(
      context: ctx,
      publicKey: FLUTTER_WAVE_PUBLIC_KEY,
      currency: "USD",
      redirectUrl: BASE_URL,
      txRef: DateTime.now().millisecond.toString(),
      amount: appStore.payableAmount.validate().toStringAsFixed(0),
      customer: customer,
      paymentOptions: "card, payattitude, barter",
      customization: Customization(title: "Pay with FlutterWave"),
      isTestMode: true,
    );

    _toggleButtonActive(false); // Disable button while processing

    await flutterWave.charge().then((value) {
      if (value.status == "successful") {
        appStore.setLoading(true);

        verifyPayment(
          transactionId: value.transactionId.validate(),
          flutterWaveSecretKey: FLUTTER_WAVE_SECRET_KEY,
        ).then((v) {
          appStore.setLoading(false);
          if (v.status == "success") {// _showSuccessMessage(ctx, "Payment successful");
            onCompleteCall.call(value);
          } else {
            _showErrorAndClose(ctx, 'Transaction Failed');
          }
        }).catchError((e) {
          appStore.setLoading(false);
          toast(e.toString());
        });
      } else {
        toast('Transaction Cancelled');
        appStore.setLoading(false);
      }
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  // Helper function to toggle button state
  void _toggleButtonActive(final bool shouldEnable) {
    isDisabled = !shouldEnable;
  }

  // Show success message on payment completion
  void _showSuccessMessage(BuildContext ctx, String message) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.green));
  }

  // Show error message on payment failure
  void _showErrorAndClose(BuildContext ctx, String errorMessage) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(errorMessage), backgroundColor: Colors.red));
  }
}

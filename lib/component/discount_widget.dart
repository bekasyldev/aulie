import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class DiscountWidget extends StatelessWidget {
  final num? discount;

  DiscountWidget({this.discount});

  @override
  Widget build(BuildContext context) {
    return Text(discount.toString() + "%", style: boldTextStyle(color: white, size: 14));
  }
}

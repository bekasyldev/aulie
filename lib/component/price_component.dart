import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class PriceComponent extends StatefulWidget {
  static String tag = '/PriceComponent';
  final num? discountedPrice;
  final num? price;
  final num? discount;
  final bool isCenter;

  PriceComponent({this.discountedPrice, this.price, this.discount, this.isCenter = false});

  @override
  PriceComponentState createState() => PriceComponentState();
}

class PriceComponentState extends State<PriceComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

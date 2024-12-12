import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/cart_response.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class PriceCalculation extends StatefulWidget {
  final List<CartModel>? cartItemList;
  final context;

  PriceCalculation({this.cartItemList, this.context, Key? key}) : super(key: key);

  @override
  PriceCalculationState createState() => PriceCalculationState();
}

class PriceCalculationState extends State<PriceCalculation> {
  double total = 0.0;
  double discount = 0.0;
  double discountPrice = 0.0;
  double mrp = 0.0;

  List<CartModel> cartItemListTemp = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setCartItem(widget.cartItemList);
  }

  void setCartItem(List<CartModel>? cartItems) async {
    cartItemListTemp.clear();

    total = 0.0;
    discount = 0.0;
    total = 0.0;

    setState(() {});

    cartItemListTemp.addAll(cartItems!);

    mrp = cartItemListTemp.sumByDouble((p0) => p0.price.validate());

    discountPrice = cartItemListTemp.where((element) => element.discountedPrice != 0).sumByDouble((p0) => p0.price.validate() - p0.discountedPrice.validate());

    // total = mrp - discountPrice;
    appStore.setPayableAmount(mrp - discountPrice);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Container(
        width: context.width(),
        decoration: boxDecorationWithRoundedCorners(
          backgroundColor: context.cardColor,
          boxShadow: defaultBoxShadow(shadowColor: grey.withOpacity(0.2), spreadRadius: 0.5, offset: Offset(0.3, 0.2), blurRadius: 1),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(language!.totalMrp, style: primaryTextStyle(), maxLines: 2, overflow: TextOverflow.ellipsis).expand(),
                8.width,
                Text('$defaultCurrencySymbol${mrp.toString()}', style: primaryTextStyle(size: 18)),
              ],
            ),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(language!.discount, style: primaryTextStyle(), maxLines: 2, overflow: TextOverflow.ellipsis).expand(),
                8.width,
                Text('$defaultCurrencySymbol${discountPrice.validate().toStringAsFixed(1)}', style: primaryTextStyle(size: 18)),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${language!.total}', style: boldTextStyle(size: 18), maxLines: 2, overflow: TextOverflow.ellipsis).expand(),
                8.width,
                Text('$defaultCurrencySymbol${appStore.payableAmount.toString()}', style: boldTextStyle(color: defaultPrimaryColor, size: 18)),
              ],
            ),
          ],
        ).paddingAll(16),
      );
    });
  }
}

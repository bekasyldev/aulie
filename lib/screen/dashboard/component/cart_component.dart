import 'package:flutter/material.dart';
import 'package:granth_flutter/component/cache_image_widget.dart';
import 'package:granth_flutter/component/price_component.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/cart_response.dart';
import 'package:nb_utils/nb_utils.dart';

class CartComponent extends StatelessWidget {
  final CartModel cartModel;
  final Function() onRemoveTap;

  CartComponent({required this.cartModel, required this.onRemoveTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      width: context.width() - 32,
      decoration: boxDecorationDefault(boxShadow: [], color: context.cardColor),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedImageWidget(
                url: cartModel.frontCover.validate(),
                height: 100,
                width: 70,
                fit: BoxFit.cover,
              ).cornerRadiusWithClipRRect(defaultRadius - 8),
              16.width,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartModel.title.validate(), style: boldTextStyle(), maxLines: 2, overflow: TextOverflow.ellipsis),
                      8.height,
                      Text(cartModel.authorName.validate(), style: secondaryTextStyle(), maxLines: 2, overflow: TextOverflow.ellipsis),
                      8.height,
                      PriceComponent(price: cartModel.price, discountedPrice: cartModel.discountedPrice),
                    ],
                  ).expand(),
                  8.width,
                ],
              ).expand()
            ],
          ),
          Positioned(
            top: -12,
            right: -12,
            child: IconButton(
              icon: Icon(Icons.clear, size: 18),
              padding: EdgeInsets.all(0),
              visualDensity: VisualDensity.compact,
              onPressed: () {
                showConfirmDialogCustom(
                  context,
                  title: language!.areYouSureWantToRemoveCart,
                  dialogType: DialogType.DELETE,
                  onAccept: (BuildContext context) {
                    onRemoveTap.call();
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

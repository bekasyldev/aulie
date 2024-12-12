import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/component/no_data_found_widget.dart';
import 'package:granth_flutter/screen/dashboard/component/cart_component.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/cart_response.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../configs.dart';

class MobileCartFragment extends StatefulWidget {
  final bool? isShowBack;

  MobileCartFragment({this.isShowBack});

  @override
  _MobileCartFragmentState createState() => _MobileCartFragmentState();
}

class _MobileCartFragmentState extends State<MobileCartFragment> {
  List<CartModel> cartItemList = [];

  @override
  void initState() {
    super.initState();
    getCart();
    afterBuildCreated(() {
      init();
      LiveStream().on(CART_DATA_CHANGED, (p0) {
        init();
        finish(context, true);
      });
    });
  }

  Future<void> init() async {
    appStore.setLoading(true);
    await getCart().then((value) {
      cartItemList = value.data.validate();
      setState(() {});
    }).catchError((e) {
      toast(e.toString());
    });
    appStore.setLoading(false);
  }

  Future<void> removeCartApi(BuildContext context, {int? itemId, int? bookId}) async {
    Map request = {
      UserKeys.id: itemId,
    };
    appStore.setLoading(true);
    removeFromCart(request).then((value) {
      appStore.setLoading(false);
      toast(value.message);
      appStore.setCartCount(appStore.cartCount - 1);
      init();
      cartItemListBookId.remove(bookId);
      LiveStream().emit(CART_DATA_CHANGED);
      setState(() {});
    }).catchError((e) {
      toast(e.toString());
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    LiveStream().dispose(CART_DATA_CHANGED);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        language!.myCart, 
        elevation: 0, 
        showBack: widget.isShowBack ?? false, 
        color: context.scaffoldBackgroundColor
      ),
      bottomNavigationBar: cartItemList.length != 0 || appStore.cartCount != 0
          ? AppButton(
              text: language!.readBook,  // Changed from 'Place Order' to 'Read Book'
              color: defaultPrimaryColor,
              width: context.width(),
              enableScaleAnimation: false,
              onTap: () {
                // Add logic to start reading the book
                // You might want to navigate to a reading screen or download the book
              },
            ).paddingAll(16)
          : SizedBox(),
      body: Stack(
        children: [
          cartItemList.length != 0 || appStore.cartCount != 0
              ? SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 30),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: cartItemList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      left: defaultRadius, 
                      right: defaultRadius, 
                      top: defaultRadius, 
                      bottom: 16
                    ),
                    itemBuilder: ((context, index) {
                      return CartComponent(
                        cartModel: cartItemList[index],
                        onRemoveTap: () {
                          removeCartApi(
                            context, 
                            itemId: cartItemList[index].cartMappingId, 
                            bookId: cartItemList[index].bookId
                          );
                          cartItemList.removeAt(index);
                          setState(() {});
                        },
                      );
                    }),
                  ),
                )
              : Observer(
                  builder: (context) => NoDataFoundWidget(
                    title: 'Your Cart is Empty',
                  ).visible(!appStore.isLoading),
                ),
          Observer(
            builder: (context) => AppLoaderWidget()
                .visible(appStore.isLoading.validate())
                .center(),
          )
        ],
      ),
    );
  }
}

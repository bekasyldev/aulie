import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/cache_image_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/network/common_api_call.dart';
import 'package:granth_flutter/screen/auth/sign_in_screen.dart';
import 'package:granth_flutter/screen/dashboard/fragment/cart_fragment.dart';
import 'package:nb_utils/nb_utils.dart';

class WebBookDetails1TopComponent extends StatefulWidget {
  static String tag = '/WebBookDetails1TopComponent';
  final BookDetailResponse? bookData;

  WebBookDetails1TopComponent({this.bookData});

  @override
  WebBookDetails1TopComponentState createState() => WebBookDetails1TopComponentState();
}

class WebBookDetails1TopComponentState extends State<WebBookDetails1TopComponent> {
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            IconButton(
              onPressed: () {
                if (appStore.isLoggedIn) {
                  CartFragment(isShowBack: true).launch(context);
                } else {
                  SignInScreen().launch(context);
                }
              },
              icon: Observer(
                builder: (context) {
                  return Badge(
                    backgroundColor: Colors.red,
                    isLabelVisible: appStore.cartCount > 0,
                    label: Text(appStore.cartCount.toString(), style: primaryTextStyle(color: Colors.white, size: 12)),
                    child: Icon(Icons.shopping_cart_outlined,size: 26,),
                    /*badgeContent: Text(appStore.cartCount.toString(), style: primaryTextStyle(color: Colors.white, size: 14)),
                    badgeColor: Colors.red,
                    showBadge: appStore.cartCount > 0,
                    position: BadgePosition.topEnd(end: -10, top: -10),
                    animationType: BadgeAnimationType.fade,
                    child: Icon(Icons.shopping_cart_outlined),*/
                  );
                },
              ),
            ),
            8.height,
            IconButton(
              onPressed: () async {
                if (appStore.isLoggedIn) {
                  if (widget.bookData!.isWishlist.validate() == 1) {
                    appStore.bookWishList.remove(widget.bookData!);
                    widget.bookData!.isWishlist = 0;
                  } else {
                    widget.bookData!.isWishlist = 1;
                    appStore.bookWishList.add(widget.bookData!);
                  }
                  setState(() {});
                  await addRemoveWishListApi(widget.bookData!.bookId.validate(), widget.bookData!.isWishlist.validate()).then((value) {}).catchError((e) {
                    log("Error : ${e.toString()}");
                  });
                } else {
                  SignInScreen().launch(context);
                }
              },
              icon: Icon(widget.bookData!.isWishlist == 1 ? Icons.favorite : Icons.favorite_outline, color: redColor),
            ),
          ],
        ).expand(),
        CachedImageWidget(
          height: 250,
          width: 180,
          url: widget.bookData!.frontCover.validate(),
          fit: BoxFit.cover,
        ).cornerRadiusWithClipRRect(defaultRadius).expand(flex: 2),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/auth/sign_in_screen.dart';
import 'package:granth_flutter/screen/dashboard/fragment/cart_fragment.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/file_common.dart';
import 'package:granth_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class BookButtonComponent extends StatefulWidget {
  static String tag = '/ButtonCommonComponent';
  final BookDetailResponse? bookDetailResponse;

  BookButtonComponent({this.bookDetailResponse});

  @override
  BookButtonComponentState createState() => BookButtonComponentState();
}

class BookButtonComponentState extends State<BookButtonComponent> {
  BookDetailResponse? mBookDetail;
  bool _purchasedFileExist = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    if (widget.bookDetailResponse != null) {
      mBookDetail = widget.bookDetailResponse;
      setState(() {});
    }

    if (isMobile) {
      _purchasedFileExist = await checkFileIsExist(
        bookId: mBookDetail!.bookId.toString(),
        bookPath: mBookDetail!.filePath.validate(),
        sampleFile: false,
      );
      appStore.setPurchasesFileStatus(_purchasedFileExist);
      setState(() {});
    }
  }

  Future<void> addBookToCart() async {
    appStore.setLoading(true);
    var request = {CommonKeys.bookId: mBookDetail!.bookId, CartModelKey.addQty: 1, BookRatingDataKey.userid: appStore.userId.validate()};
    await addToCart(request).then((result) {
      toast(result.message);
      appStore.setCartCount(appStore.cartCount = appStore.cartCount + 1);
      appStore.setLoading(false);
      cartItemListBookId.add(mBookDetail!.bookId.validate());
      LiveStream().emit(CART_DATA_CHANGED);
      setState(() {});
    }).catchError((error) {
      appStore.setLoading(false);
      toast(error.toString());
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: transparentColor,
      child: Row(
        children: [
          widget.bookDetailResponse!.isPurchase != 1 && widget.bookDetailResponse!.price != 0
              ? Observer(
                  builder: (context) {
                    return AppButton(
                      enableScaleAnimation: false,
                      color: defaultPrimaryColor,
                      width: context.width(),
                      child: Marquee(
                        child: Text(
                          cartItemListBookId.any((e) => e == widget.bookDetailResponse!.bookId) ? language!.goToCart : language!.addToCart,
                          style: boldTextStyle(size: 14, color: whiteColor),
                        ),
                      ),
                      onTap: () async {
                        bool isCart = cartItemListBookId.any(
                          (element) {
                            return element == widget.bookDetailResponse!.bookId;
                          },
                        );

                        if (appStore.isLoggedIn) {
                          if (isCart) {
                            CartFragment(isShowBack: true).launch(context);
                          } else {
                            await addBookToCart();
                          }
                        } else {
                          SignInScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                        }
                      },
                    ).expand();
                  },
                )
              : Offstage(),
          widget.bookDetailResponse!.isPurchase == 1 || widget.bookDetailResponse!.price == 0
              ? AppButton(
                  enableScaleAnimation: false,
                  child: Marquee(child: Text(language!.readBook, style: boldTextStyle(size: 14, color: whiteColor))),
                  color: defaultPrimaryColor,
                  width: context.width(),
                  onTap: () async {
                    if (appStore.isDownloading) {
                      toast(language!.pleaseWait);
                    } else {
                      downloadBook(context, bookDetailResponse: widget.bookDetailResponse, isSample: false);
                    }
                  },
                ).expand()
              : Offstage(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/cache_image_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/network/common_api_call.dart';
import 'package:granth_flutter/screen/auth/sign_in_screen.dart';
import 'package:granth_flutter/screen/dashboard/fragment/cart_fragment.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class BookDetails1TopComponent extends StatefulWidget {
  static String tag = '/BookDetails1TopComponent';
  final BookDetailResponse? bookData;

  BookDetails1TopComponent({this.bookData});

  @override
  BookDetails1TopComponentState createState() => BookDetails1TopComponentState();
}

class BookDetails1TopComponentState extends State<BookDetails1TopComponent> {
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
    return Stack(
      children: [
        CachedImageWidget(
          height: 250,
          width: 180,
          url: widget.bookData!.frontCover.validate(),
          fit: BoxFit.cover,
        ).cornerRadiusWithClipRRect(defaultRadius).center(),
        Positioned(
          top: 0,
          left: rtlSupport.contains(appStore.selectedLanguageCode) ? 16 : null,
          right: rtlSupport.contains(appStore.selectedLanguageCode) ? null : 16,
          child: Column(
            children: [
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
          ),
        )
      ],
    );
  }
}

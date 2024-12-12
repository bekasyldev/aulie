import 'package:flutter/material.dart';
import 'package:granth_flutter/component/discount_widget.dart';
import 'package:granth_flutter/component/ink_well_widget.dart';
import 'package:granth_flutter/component/price_component.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/network/common_api_call.dart';
import 'package:granth_flutter/screen/book/book_details_screen1.dart';
import 'package:granth_flutter/screen/book/book_details_screen2.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class BookComponent extends StatefulWidget {
  static String tag = '/ BookListBookComponent';

  final BookDetailResponse? bookData;
  final double? bookWidth;
  final bool? isWishList;
  final bool? isCenterBookInfo;
  final double? isLeftDisTag;

  BookComponent({this.bookData, this.bookWidth, this.isWishList = false, this.isCenterBookInfo = false, this.isLeftDisTag});

  @override
  BookComponentState createState() => BookComponentState();
}

class BookComponentState extends State<BookComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.bookWidth,
      child: Column(
        crossAxisAlignment: widget.isCenterBookInfo! ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWellWidget(
                image: widget.bookData!.frontCover.validate(value: bookFrontCoverIfCoverNotAvailable),
                onTap: () {
                  if (isMobile) {
                    if (appStore.pageVariant == 1) {
                      BookDetailsScreen1(bookId: widget.bookData!.bookId.validate(), bookDetailResponse: widget.bookData).launch(context);
                    } else {
                      BookDetailsScreen2(bookId: widget.bookData!.bookId.validate()).launch(context);
                    }
                  } else {
                    BookDetailsScreen1(bookId: widget.bookData!.bookId.validate(), bookDetailResponse: widget.bookData).launch(context);
                  }
                },
              ).cornerRadiusWithClipRRect(defaultRadius),
              Positioned(
                top: 4,
                left: widget.isLeftDisTag != null ? widget.isLeftDisTag : 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(discount_img, height: 24, width: 60, fit: BoxFit.fill),
                    DiscountWidget(discount: widget.bookData!.discount.validate()),
                  ],
                ),
              ).visible(widget.bookData!.discount.validate() != 0),
              Positioned(
                top: 0,
                right: widget.isWishList! ? 12 : 0,
                child: IconButton(
                  splashRadius: 24,
                  padding: EdgeInsets.all(0),
                  color: redColor,
                  icon: widget.bookData!.isWishlist == 0 ? Icon(Icons.favorite_border_rounded) : Icon(Icons.favorite_rounded),
                  onPressed: () async {
                    showConfirmDialogCustom(
                      context,
                      title: language!.areYouSureWant,
                      dialogType: DialogType.DELETE,
                      onAccept: (BuildContext context) async {
                        await addRemoveWishListApi(widget.bookData!.bookId.validate(), widget.bookData!.isWishlist == 0 ? 1 : 0).then(
                          (value) {
                            widget.bookData!.isWishlist = 0;
                            appStore.bookWishList.remove(widget.bookData!);
                            setState(() {});
                          },
                        );
                      },
                    );
                  },
                ),
              ).visible(widget.isWishList!)
            ],
          ),
          8.height,
          SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Marquee(
                  child: Text(
                    widget.bookData!.name.validate().capitalizeFirstLetter(),
                    style: boldTextStyle(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                8.height,
                Text(widget.bookData!.authorName.validate(), style: primaryTextStyle(size: 14), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis),
                4.height,
                PriceComponent(
                  isCenter: false,
                  discount: widget.bookData!.discount.validate(),
                  discountedPrice: widget.bookData!.discountedPrice.validate(),
                  price: widget.bookData!.price.validate(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

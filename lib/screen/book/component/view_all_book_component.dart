import 'package:flutter/material.dart';
import 'package:granth_flutter/component/discount_widget.dart';
import 'package:granth_flutter/component/ink_well_widget.dart';
import 'package:granth_flutter/component/price_component.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/screen/book/book_details_screen1.dart';
import 'package:granth_flutter/screen/book/book_details_screen2.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class ViewAllBookComponent extends StatefulWidget {
  static String tag = '/ViewAllBookComponent';
  final BookDetailResponse? bookDetailResponse;
  final bool? isViewAllBooks;
  final double? width;
  final double? discountTag;

  ViewAllBookComponent({required this.bookDetailResponse, this.isViewAllBooks = false, this.width, this.discountTag});

  @override
  ViewAllBookComponentState createState() => ViewAllBookComponentState();
}

class ViewAllBookComponentState extends State<ViewAllBookComponent> {
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
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: widget.isViewAllBooks! ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              InkWellWidget(
                image: widget.bookDetailResponse!.frontCover.validate(),
                onTap: () {
                  if (isMobile) {
                    if (appStore.pageVariant == 1) {
                      BookDetailsScreen1(
                        bookId: widget.bookDetailResponse!.bookId.validate(),
                        bookDetailResponse: widget.bookDetailResponse,
                      ).launch(context);
                    } else {
                      BookDetailsScreen2(bookId: widget.bookDetailResponse!.bookId.validate()).launch(context);
                    }
                  } else {
                    BookDetailsScreen1(
                      bookId: widget.bookDetailResponse!.bookId.validate(),
                      bookDetailResponse: widget.bookDetailResponse,
                    ).launch(context);
                  }
                },
              ).cornerRadiusWithClipRRect(defaultRadius),
              Positioned(
                top: 4,
                left: widget.discountTag != null ? widget.discountTag : 0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(discount_img, height: 24, width: 60, fit: BoxFit.fill),
                    DiscountWidget(discount: widget.bookDetailResponse!.discount.validate()),
                  ],
                ),
              ).visible(widget.bookDetailResponse!.discount.validate() != 0),
            ],
          ),
          12.height,
          SizedBox(
            width: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Marquee(
                  child: Text(
                    widget.bookDetailResponse!.name.validate(),
                    style: boldTextStyle(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                8.height,
                Text(
                  widget.bookDetailResponse!.authorName.validate(),
                  style: primaryTextStyle(size: 14),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
                4.height,
                PriceComponent(
                  discount: widget.bookDetailResponse!.discount.validate(),
                  discountedPrice: widget.bookDetailResponse!.discountedPrice.validate(),
                  price: widget.bookDetailResponse?.price.validate(),
                ),
              ],
            ),
          ),
        ],
      ),
    ).onTap(() {
      if (isMobile) {
        if (appStore.pageVariant == 1) {
          BookDetailsScreen1(
            bookId: widget.bookDetailResponse!.bookId.validate(),
            bookDetailResponse: widget.bookDetailResponse,
          ).launch(context);
        } else {
          BookDetailsScreen2(bookId: widget.bookDetailResponse!.bookId.validate()).launch(context);
        }
      } else {
        BookDetailsScreen1(
          bookId: widget.bookDetailResponse!.bookId.validate(),
          bookDetailResponse: widget.bookDetailResponse,
        ).launch(context);
      }
    }, splashColor: transparentColor, highlightColor: transparentColor);
  }
}

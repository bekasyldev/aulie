import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/cache_image_widget.dart';
import 'package:granth_flutter/component/download_widget.dart';
import 'package:granth_flutter/component/price_component.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/all_book_details_model.dart';
import 'package:granth_flutter/network/common_api_call.dart';
import 'package:granth_flutter/screen/auth/sign_in_screen.dart';
import 'package:granth_flutter/screen/dashboard/fragment/cart_fragment.dart';
import 'package:nb_utils/nb_utils.dart';

class BookDetails2TopComponent extends StatefulWidget {
  static String tag = '/BookDetails2TopComponent';
  final AllBookDetailsModel? allBookDetailsModel;

  BookDetails2TopComponent({this.allBookDetailsModel});

  @override
  BookDetails2TopComponentState createState() => BookDetails2TopComponentState();
}

class BookDetails2TopComponentState extends State<BookDetails2TopComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        Stack(
          children: [
            Container(
              height: context.height() * .35,
              width: context.width(),
              decoration: BoxDecoration(
                image: DecorationImage(image: Image.network(widget.allBookDetailsModel!.bookDetailResponse!.first.frontCover.validate()).image, fit: BoxFit.cover),
              ),
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(padding: EdgeInsets.only(top: 22, left: 20), width: context.width(), color: Colors.black.withOpacity(0.1)),
                ),
              ),
            ),
            Positioned(
              top: 24,
              left: 16,
              bottom: 24,
              child: CachedImageWidget(
                height: 0,
                width: 180,
                url: widget.allBookDetailsModel!.bookDetailResponse!.first.frontCover.validate(),
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
        Container(
          width: context.width(),
          margin: EdgeInsets.only(top: context.height() * .34),
          decoration: boxDecorationWithRoundedCorners(
            backgroundColor: context.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          padding: EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.allBookDetailsModel!.bookDetailResponse!.first.title.validate().capitalizeFirstLetter(),
                            style: boldTextStyle(size: 18),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          8.height,
                          Text(
                            widget.allBookDetailsModel!.bookDetailResponse!.first.categoryName.validate().capitalizeFirstLetter(),
                            style: primaryTextStyle(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          8.height,
                          PriceComponent(
                            price: widget.allBookDetailsModel!.bookDetailResponse!.first.price.validate(),
                            discount: widget.allBookDetailsModel!.bookDetailResponse!.first.discount.validate(),
                            discountedPrice: widget.allBookDetailsModel!.bookDetailResponse!.first.discountedPrice.validate(),
                          ),
                          4.height,
                          if (widget.allBookDetailsModel!.bookRatingData.validate().isNotEmpty)
                            RatingBarWidget(
                              allowHalfRating: false,
                              disable: true,
                              itemCount: 5,
                              size: 24,
                              activeColor: Colors.amber,
                              rating: widget.allBookDetailsModel!.bookRatingData!.first.rating.validate().toDouble(),
                              onRatingChanged: (value) {
                                setState(() {});
                              },
                            )
                        ],
                      ).expand(),
                      8.width,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () async {
                              if (appStore.isLoggedIn) {
                                if (widget.allBookDetailsModel!.bookDetailResponse!.first.isWishlist == 1) {
                                  toast(language!.removed);
                                  appStore.bookWishList.remove(widget.allBookDetailsModel!.bookDetailResponse!.first);
                                  widget.allBookDetailsModel!.bookDetailResponse!.first.isWishlist = 0;
                                } else {
                                  toast(language!.added);
                                  widget.allBookDetailsModel!.bookDetailResponse!.first.isWishlist = 1;
                                  appStore.bookWishList.add(widget.allBookDetailsModel!.bookDetailResponse!.first);
                                }
                                setState(() {});
                                await addRemoveWishListApi(
                                  widget.allBookDetailsModel!.bookDetailResponse!.first.bookId.validate(),
                                  widget.allBookDetailsModel!.bookDetailResponse!.first.isWishlist.validate(),
                                ).then((value) {
                                  //
                                }).catchError((e) {
                                  log("Error : ${e.toString()}");
                                });
                              } else {
                                SignInScreen().launch(context);
                              }
                            },
                            icon: Icon(
                              widget.allBookDetailsModel!.bookDetailResponse!.first.isWishlist.validate() == 1 ? Icons.favorite : Icons.favorite_outline,
                              color: redColor,
                            ),
                          ).visible(appStore.isLoggedIn)
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Observer(
                builder: (context) {
                  return DownloadWidget(
                    downloadPercentage: appStore.downloadPercentageStore,
                  ).visible(appStore.isDownloading);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

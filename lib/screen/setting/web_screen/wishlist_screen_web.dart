import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/component/no_data_found_widget.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/screen/book/component/book_component.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class WebWishListScreen extends StatelessWidget {
  WebWishListScreen({required this.wishList, this.width});

  final List<BookDetailResponse>? wishList;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: appBarWidget('', showBack: false, elevation: 0, color: context.dividerColor.withOpacity(0.1)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              WebBreadCrumbWidget(context, title: language!.myWishlist, subTitle1: 'Home', subTitle2: language!.myWishlist),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: context.width() * 0.8, minWidth: context.width() * 0.8),
                child: Stack(
                  children: [
                    if (!appStore.isLoading)
                      wishList!.isEmpty
                          ? NoDataFoundWidget()
                          : Align(
                              alignment: Alignment.center,
                              child: Wrap(
                                spacing: 22,
                                runSpacing: 22,
                                children: wishList!.map(
                                  (element) {
                                    BookDetailResponse mData = wishList![wishList!.indexOf(element)];
                                    return Container(
                                      width: width,
                                      padding: EdgeInsets.all(defaultRadius),
                                      decoration: boxDecorationDefault(boxShadow: [BoxShadow(color: Colors.transparent)], color: defaultPrimaryColor.withOpacity(0.1)),
                                      child: BookComponent(bookData: mData, isCenterBookInfo: true, isWishList: true, isLeftDisTag: 70),
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                    if (appStore.isLoading)
                      Observer(
                        builder: (context) {
                          return AppLoaderWidget().center();
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

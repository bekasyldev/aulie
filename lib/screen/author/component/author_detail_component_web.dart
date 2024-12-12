import 'package:flutter/material.dart';
import 'package:granth_flutter/component/cache_image_widget.dart';
import 'package:granth_flutter/component/no_data_found_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/author_model.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/screen/book/component/book_component.dart';
import 'package:granth_flutter/screen/dashboard/component/see_all_component.dart';
import 'package:granth_flutter/utils/colors.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class WebAuthorDetailComponent extends StatelessWidget {
  final AuthorResponse? authorData;
  final List<BookDetailResponse>? authorBookList;

  WebAuthorDetailComponent({this.authorData, this.authorBookList});

  @override
  Widget build(BuildContext context) {
    double partition = screenSizePartition(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: context.width(),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: boxDecorationDefault(boxShadow: [BoxShadow(color: Colors.transparent)], color: appStore.isDarkMode ? scaffoldSecondaryDark : Colors.white),
          child: Column(
            children: [
              Row(
                children: [
                  CachedImageWidget(
                    url: authorData!.image.validate(),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ).cornerRadiusWithClipRRect(50),
                  16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(authorData!.name.validate(), style: boldTextStyle(size: 20)),
                      if (authorData!.designation!.isNotEmpty) 4.height,
                      Marquee(child: Text(authorData!.designation!.validate(), style: primaryTextStyle(), maxLines: 1)),
                      if (authorData!.address!.isNotEmpty) 8.height,
                      Marquee(child: Text(authorData!.address.validate(), style: secondaryTextStyle(size: 12), maxLines: 3)),
                      if (authorData!.address!.isNotEmpty) 16.height,
                    ],
                  ).expand(),
                ],
              ),
              20.height,
              Divider(height: 0),
              30.height,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(language!.aboutMe, style: boldTextStyle(size: 18)),
                  10.height,
                  ReadMoreText(authorData!.description.validate(), textAlign: TextAlign.justify, style: primaryTextStyle(), colorClickableText: Colors.grey),
                ],
              ),
            ],
          ),
        ).expand(flex: 3),
        Container(
          width: context.width(),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: boxDecorationDefault(boxShadow: [BoxShadow(color: Colors.transparent)], color: appStore.isDarkMode ? scaffoldSecondaryDark : Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (authorBookList!.length != 0 && !appStore.isLoading)
                SeeAllComponent(
                  title: language!.books,
                  isShowSeeAll: false,
                  onClick: () {},
                ),
              16.height,
              Divider(height: 0),
              20.height,
              authorBookList!.length == 0 && !appStore.isLoading
                  ? NoDataFoundWidget()
                  : Wrap(
                      spacing: 22,
                      runSpacing: 22,
                      children: List.generate(authorBookList!.length, (index) {
                        BookDetailResponse mData = authorBookList![index];
                        return SizedBox(
                          width: (context.width() / partition) - 180,
                          child: BookComponent(bookData: mData, isCenterBookInfo: true, isLeftDisTag: 50),
                        );
                      }),
                    ),
            ],
          ),
        ).expand(flex: 7),
      ],
    ).paddingBottom(16);
  }
}

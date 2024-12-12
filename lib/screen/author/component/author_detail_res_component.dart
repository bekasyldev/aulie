import 'package:flutter/material.dart';
import 'package:granth_flutter/component/cache_image_widget.dart';
import 'package:granth_flutter/component/no_data_found_widget.dart';
import 'package:granth_flutter/screen/book/component/book_component.dart';
import 'package:granth_flutter/screen/dashboard/component/see_all_component.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/author_model.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthorDetailResComponent extends StatelessWidget {
  final AuthorResponse? authorData;
  final List<BookDetailResponse>? authorBookList;

  AuthorDetailResComponent({this.authorData, this.authorBookList});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedImageWidget(
                  url: authorData!.image.validate(),
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ).cornerRadiusWithClipRRect(40),
                16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(authorData!.name.validate(), style: boldTextStyle(size: 18), maxLines: 2),
                    if (authorData!.designation!.isNotEmpty) 4.height,
                    Marquee(child: Text(authorData!.designation!.validate(), style: primaryTextStyle(), maxLines: 1)),
                    if (authorData!.address!.isNotEmpty) 8.height,
                    Marquee(child: Text(authorData!.address.validate(), style: secondaryTextStyle(), maxLines: 3)),
                    if (authorData!.address!.isNotEmpty) 16.height,
                  ],
                ),
              ],
            ).paddingAll(defaultRadius),
            Divider(height: 0),
            24.height,
            Text(language!.aboutMe, style: boldTextStyle(size: 20)).paddingSymmetric(horizontal: defaultRadius),
            16.height,
            ReadMoreText(
              authorData!.description.validate(),
              textAlign: TextAlign.justify,
              style: primaryTextStyle(),
              colorClickableText: Colors.grey,
            ).paddingSymmetric(horizontal: defaultRadius),
            24.height,
            if (authorBookList!.length != 0 && !appStore.isLoading)
              SeeAllComponent(
                title: language!.books,
                isShowSeeAll: false,
                onClick: () {},
              ).paddingSymmetric(horizontal: defaultRadius),
            16.height,
            authorBookList!.length == 0 && !appStore.isLoading
                ? NoDataFoundWidget()
                : HorizontalList(
                    itemCount: authorBookList!.length,
                    spacing: 16,
                    runSpacing: 0,
                    padding: EdgeInsets.symmetric(horizontal: defaultRadius),
                    itemBuilder: (context, index) {
                      BookDetailResponse mData = authorBookList![index];
                      return BookComponent(bookData: mData);
                    },
                  ),
            16.height,
          ],
        ),
      ],
    );
  }
}

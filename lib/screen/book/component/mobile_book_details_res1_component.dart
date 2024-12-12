import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/component/download_widget.dart';
import 'package:granth_flutter/models/all_book_details_model.dart';
import 'package:granth_flutter/models/book_ratting_list_model.dart';
import 'package:granth_flutter/screen/book/all_review_list_screen.dart';
import 'package:granth_flutter/screen/book/component/book_button_component.dart';
import 'package:granth_flutter/screen/book/component/book_details1_category_component.dart';
import 'package:granth_flutter/screen/book/component/book_details1_top_component.dart';
import 'package:granth_flutter/screen/book/component/book_list_component.dart';
import 'package:granth_flutter/screen/book/component/ratting_list_component.dart';
import 'package:granth_flutter/screen/book/component/ratting_view_component.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/screen/book/component/write_review_component.dart';
import 'package:granth_flutter/screen/book/view_all_book_screen.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/screen/dashboard/component/see_all_component.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileBookDetailsRes1Component extends StatelessWidget {
  final AllBookDetailsModel bookData;
  final int? bookId;

  MobileBookDetailsRes1Component({required this.bookData, this.bookId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: context.height(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BookDetails1TopComponent(bookData: bookData.bookDetailResponse!.first),
                  16.height,
                  Text(
                    bookData.bookDetailResponse!.first.name.validate().capitalizeFirstLetter(),
                    style: boldTextStyle(size: 18),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ).center(),
                  8.height,
                  Text(bookData.authorDetail!.first.name.validate(), style: secondaryTextStyle()).center(),
                  16.height,

                  /// ratting list
                  RattingViewComponent(bookDetailResponse: bookData.bookDetailResponse!.first, isCenterInfo: true),
                  16.height,

                  /// category name
                  BookDetails1CategoryComponent(bookDetailResponse: bookData.bookDetailResponse!.first, isCenterInfo: true),
                  24.height,

                  ///Introduction title
                  Text(language!.introduction, style: boldTextStyle(size: 24)),
                  8.height,
                  ReadMoreText(
                    bookData.bookDetailResponse!.first.description.validate(),
                    textAlign: TextAlign.justify,
                    style: primaryTextStyle(),
                    colorClickableText: Colors.grey,
                  ),
                  if (bookData.bookRatingData!.length != 0) 24.height,
                  if (bookData.bookRatingData!.length != 0)

                    ///Top Review
                    SeeAllComponent(
                      isShowSeeAll: bookData.bookRatingData!.length != 0 ? true : false,
                      title: language!.topReviews,
                      onClick: () async {
                        AllReviewListScreen(
                          bookRatingData: bookData.bookRatingData.validate(),
                          totalRatting: bookData.bookDetailResponse!.first.totalRating.validate(),
                          bookId: bookId,
                        ).launch(context);
                      },
                    ),

                  if (bookData.bookRatingData!.any((element) => element.userId == appStore.userId))
                    SizedBox()
                  else
                    Align(
                      alignment: Alignment.topRight,
                      child: AppButton(
                        enableScaleAnimation: false,
                        text: language!.writeReview,
                        height: 20,
                        color: defaultPrimaryColor,
                        onTap: () {
                          showInDialog(
                            context,
                            shape: RoundedRectangleBorder(borderRadius: radius(defaultRadius)),
                            contentPadding: EdgeInsets.all(0),
                            builder: (BuildContext context) {
                              BookRatingData? mData;

                              bool isReview = bookData.bookRatingData!.any((element) => element.userId == appStore.userId);
                              if (isReview) mData = bookData.bookRatingData!.firstWhere((element) => element.userId == appStore.userId);

                              return WriteReviewComponent(bookRatingData: mData, bookId: bookId, isUpdate: false);
                            },
                          );
                        },
                      ),
                    ).paddingOnly(top: 16).visible(appStore.isLoggedIn),
                  16.height,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: bookData.bookRatingData!.length,
                    itemBuilder: (BuildContext context, int index) {
                      BookRatingData mData = bookData.bookRatingData![index];
                      return RattingListComponent(
                        bookRatingData: mData,
                        bookId: bookId,
                      ).paddingSymmetric(vertical: 8);
                    },
                  ),
                  24.height,
                  if (bookData.recommendedBook!.isNotEmpty)

                    ///Recommended Book
                    SeeAllComponent(
                      isShowSeeAll: true,
                      title: language!.recommendedBooks,
                      onClick: () {
                        ViewAllBookScreen(type: RECOMMENDED_BOOKS, title: language!.recommendedBooks).launch(context);
                      },
                    ),
                  16.height,
                  BookListComponent(bookDetailsList: bookData.recommendedBook, padding: 0),
                  24.height,

                  if (bookData.authorBookList!.isNotEmpty)

                    ///Author Book
                    SeeAllComponent(isShowSeeAll: false, title: language!.authorBook),
                  16.height,
                  BookListComponent(bookDetailsList: bookData.authorBookList, padding: 0).paddingBottom(64),
                ],
              ),
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: BookButtonComponent(bookDetailResponse: bookData.bookDetailResponse!.first)),
          Positioned(
            top: 0,
            left: rtlSupport.contains(appStore.selectedLanguageCode) ? null : 0,
            right: rtlSupport.contains(appStore.selectedLanguageCode) ? 0 : null,
            child: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                finish(context);
              },
            ),
          ),
          Observer(builder: (context) {
            return AppLoaderWidget().center().visible(appStore.isLoading);
          }),
          Observer(
            builder: (context) {
              return DownloadWidget(
                downloadPercentage: appStore.downloadPercentageStore,
              ).visible(appStore.isDownloading);
            },
          ),
        ],
      ).paddingAll(16),
    );
  }
}

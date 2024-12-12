import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/component/download_widget.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/all_book_details_model.dart';
import 'package:granth_flutter/models/book_ratting_list_model.dart';
import 'package:granth_flutter/screen/book/all_review_list_screen.dart';
import 'package:granth_flutter/screen/book/component/book_button_component.dart';
import 'package:granth_flutter/screen/book/component/book_details1_category_component.dart';
import 'package:granth_flutter/screen/book/component/book_information_component.dart';
import 'package:granth_flutter/screen/book/component/book_list_component.dart';
import 'package:granth_flutter/screen/book/component/ratting_list_component.dart';
import 'package:granth_flutter/screen/book/component/ratting_review_component.dart';
import 'package:granth_flutter/screen/book/component/ratting_view_component.dart';
import 'package:granth_flutter/screen/book/component/write_review_component.dart';
import 'package:granth_flutter/screen/book/view_all_book_screen.dart';
import 'package:granth_flutter/screen/book/web_screen/component/web_book_details1_top_component.dart';
import 'package:granth_flutter/screen/dashboard/component/see_all_component.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class WebBookDetails1Screen extends StatelessWidget {
  final AllBookDetailsModel bookData;
  final int? bookId;

  WebBookDetails1Screen({required this.bookData, this.bookId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          WebBookDetails1TopComponent(bookData: bookData.bookDetailResponse!.first).expand(flex: 2),
                          40.width,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bookData.bookDetailResponse!.first.name.validate().capitalizeFirstLetter(),
                                style: boldTextStyle(size: 40),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              8.height,
                              Text(bookData.authorDetail!.first.name.validate(), style: secondaryTextStyle()),
                              20.height,

                              /// category name
                              BookDetails1CategoryComponent(bookDetailResponse: bookData.bookDetailResponse!.first),
                              20.height,

                              /// ratting list
                              RattingViewComponent(bookDetailResponse: bookData.bookDetailResponse!.first),

                              /// Download Sample and Add to cart buttons
                              20.height,
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: context.width() * 0.2, minWidth: context.width() * 0.2),
                                child: BookButtonComponent(bookDetailResponse: bookData.bookDetailResponse!.first),
                              ),
                            ],
                          ).expand(flex: 8),
                        ],
                      ),

                      60.height,

                      ///Introduction title
                      Text(language!.overview, style: boldTextStyle(size: 24)),
                      16.height,
                      ReadMoreText(
                        bookData.bookDetailResponse!.first.description.validate(),
                        textAlign: TextAlign.justify,
                        style: primaryTextStyle(),
                        colorClickableText: Colors.grey,
                      ),

                      24.height,
                      Text(language!.information, style: boldTextStyle(size: 24)),
                      16.height,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BooksInformationComponent(allBookDetailsModel: bookData).expand(flex: 5),
                          35.width,
                          Container(
                            padding: EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: context.dividerColor),
                              borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (bookData.bookRatingData!.length != 0)

                                  ///Top Review
                                  Row(
                                    children: [
                                      Text(language!.topReviews, style: boldTextStyle(size: 20, color: textPrimaryColorGlobal)).expand(),
                                      if (bookData.bookRatingData!.any((element) => element.userId == appStore.userId))
                                        SizedBox()
                                      else
                                        AppButton(
                                          enableScaleAnimation: false,
                                          text: language!.writeReview,
                                          textColor: Colors.black,
                                          color: Colors.white,
                                          height: 20,
                                          onTap: () {
                                            showInDialog(
                                              context,
                                              shape: RoundedRectangleBorder(borderRadius: radius()),
                                              contentPadding: EdgeInsets.all(0),
                                              builder: (BuildContext context) {
                                                BookRatingData? mData;

                                                bool isReview = bookData.bookRatingData!.any((element) => element.userId == appStore.userId);
                                                if (isReview) mData = bookData.bookRatingData!.firstWhere((element) => element.userId == appStore.userId);

                                                return WriteReviewComponent(bookRatingData: mData, bookId: bookId, isUpdate: false);
                                              },
                                            );
                                          },
                                        ).visible(appStore.isLoggedIn),
                                    ],
                                  ),

                                24.height,

                                /// Reviews
                                Container(
                                  width: 400,
                                  child: RattingReviewComponent(
                                    bookId: bookId,
                                    totalRatting: bookData.bookDetailResponse!.first.totalRating.validate(),
                                  ),
                                ),

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

                                if (bookData.bookRatingData!.length != 0 ? true : false)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      child: Text(language!.seeAll, style: boldTextStyle(color: defaultPrimaryColor, size: 18)),
                                      onTap: () {
                                        AllReviewListScreen(
                                          bookRatingData: bookData.bookRatingData.validate(),
                                          totalRatting: bookData.bookDetailResponse!.first.totalRating.validate(),
                                          bookId: bookId,
                                          webBookName: bookData.bookDetailResponse!.first.name.validate().capitalizeFirstLetter(),
                                        ).launch(context);
                                      },
                                    ),
                                  ).paddingTop(10)
                              ],
                            ),
                          ).expand(flex: 5),
                        ],
                      ),

                      30.height,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          BookListComponent(bookDetailsList: bookData.recommendedBook, padding: 0, isBookDetailsScreen1: true),
                          30.height,
                          if (bookData.authorBookList!.isNotEmpty)

                            ///Author Book
                            SeeAllComponent(isShowSeeAll: false, title: language!.authorBook),
                          16.height,
                          BookListComponent(bookDetailsList: bookData.authorBookList, padding: 0, isBookDetailsScreen1: true),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12,
            left: rtlSupport.contains(appStore.selectedLanguageCode) ? null : 12,
            right: rtlSupport.contains(appStore.selectedLanguageCode) ? 12 : null,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              iconSize: 24,
              color: appStore.isDarkMode ? Colors.white : Colors.black,
              onPressed: () => finish(context),
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
      ),
    );
  }
}

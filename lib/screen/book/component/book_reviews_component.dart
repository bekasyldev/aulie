import 'package:flutter/material.dart';
import 'package:granth_flutter/models/book_ratting_list_model.dart';
import 'package:granth_flutter/screen/book/component/ratting_list_component.dart';
import 'package:granth_flutter/screen/dashboard/component/see_all_component.dart';
import 'package:granth_flutter/screen/book/component/write_review_component.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/all_book_details_model.dart';
import 'package:granth_flutter/screen/book/all_review_list_screen.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class BookReviewsComponent extends StatefulWidget {
  static String tag = '/BookReviewComponent';
  final AsyncSnapshot<AllBookDetailsModel> snap;
  final int? bookId;

  BookReviewsComponent(this.snap, {this.bookId});

  @override
  BookReviewsComponentState createState() => BookReviewsComponentState();
}

class BookReviewsComponentState extends State<BookReviewsComponent> {
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
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ///Top Review
            SeeAllComponent(
                isShowSeeAll: widget.snap.data!.bookRatingData!.length != 0 ? true : false,
                title: language!.topReviews,
                onClick: () async {
                  AllReviewListScreen(
                    bookRatingData: widget.snap.data!.bookRatingData!.validate(),
                    totalRatting: widget.snap.data!.bookDetailResponse!.first.totalRating,
                    bookId: widget.bookId,
                    webBookName: widget.snap.data!.bookDetailResponse!.first.title,
                  ).launch(context);
                }).paddingAll(16),

            if (widget.snap.data!.bookRatingData!.any((element) => element.userId == appStore.userId))
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
                      shape: RoundedRectangleBorder(borderRadius: radius()),
                      contentPadding: EdgeInsets.all(0),
                      builder: (BuildContext context) {
                        return WriteReviewComponent(bookRatingData: widget.snap.data?.bookRatingData!.first, bookId: widget.bookId, isUpdate: false);
                      },
                    );
                  },
                ),
              ).paddingOnly(right: 16, top: 0, bottom: 16).visible(appStore.isLoggedIn),

            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.snap.data!.bookRatingData!.length,
              itemBuilder: (BuildContext context, int index) {
                BookRatingData mData = widget.snap.data!.bookRatingData![index];
                return RattingListComponent(
                  bookRatingData: mData,
                  bookId: widget.bookId,
                ).paddingOnly(left: 16, right: 16, bottom: 16);
              },
            ),
          ],
        ),
      ),
    );
  }
}

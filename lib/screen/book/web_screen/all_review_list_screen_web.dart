import 'package:flutter/material.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/book_ratting_list_model.dart';
import 'package:granth_flutter/screen/book/component/ratting_list_component.dart';
import 'package:granth_flutter/screen/book/component/review_text_component.dart';
import 'package:granth_flutter/utils/colors.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class WebAllReviewListScreen extends StatelessWidget {
  final num? totalRatting;

  final int? bookId;

  final String? bookName;

  final List<BookRatingData>? ratingList;

  final double? oneStarTotal;
  final double? twoStarTotal;
  final double? threeStarTotal;
  final double? fourStarTotal;
  final double? fiveStarTotal;

  WebAllReviewListScreen({
    this.totalRatting,
    this.bookId,
    this.ratingList,
    this.oneStarTotal,
    this.twoStarTotal,
    this.threeStarTotal,
    this.fourStarTotal,
    this.fiveStarTotal,
    this.bookName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("", elevation: 0, color: context.dividerColor.withOpacity(0.1)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WebBreadCrumbWidget(context, title: language!.reviews, subTitle1: '${bookName.validate()}', subTitle2: language!.reviews),
            Stack(
              children: [
                if (!appStore.isLoading)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 25, left: 50),
                        child: Column(
                          children: [
                            32.height,
                            TextIcon(
                              text: totalRatting!.toStringAsFixed(1).toDouble().toString().validate(),
                              textStyle: boldTextStyle(size: 48),
                              spacing: 4,
                              suffix: Icon(Icons.star, color: Colors.amber, size: 48),
                            ),
                            16.height,
                            ReviewTextComponent(label: '1', totalValue: oneStarTotal, color: poor, width: 800),
                            4.height,
                            ReviewTextComponent(label: '2', totalValue: twoStarTotal, color: belowAverage, width: 800),
                            4.height,
                            ReviewTextComponent(label: '3', totalValue: threeStarTotal, color: average, width: 800),
                            4.height,
                            ReviewTextComponent(label: '4', totalValue: fourStarTotal, color: good, width: 800),
                            4.height,
                            ReviewTextComponent(label: '5', totalValue: fiveStarTotal, color: excellent, width: 800),
                            8.height
                          ],
                        ),
                      ).expand(),
                      if (ratingList.validate().length != 0)
                        ListView.builder(
                          padding: EdgeInsets.only(bottom: 16),
                          shrinkWrap: true,
                          itemCount: ratingList.validate().length,
                          itemBuilder: (BuildContext context, int index) {
                            BookRatingData mData = ratingList.validate()[index];
                            return RattingListComponent(
                              bookId: bookId,
                              bookRatingData: mData,
                            ).paddingSymmetric(horizontal: 16, vertical: 8);
                          },
                        ).expand()
                      else
                        NoDataWidget(title: language!.noDataFound).expand(flex: 6),
                    ],
                  )
                else
                  AppLoaderWidget().center(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

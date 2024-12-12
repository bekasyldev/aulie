import 'package:flutter/material.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/book_ratting_list_model.dart';
import 'package:granth_flutter/screen/book/component/ratting_list_component.dart';
import 'package:granth_flutter/screen/book/component/review_text_component.dart';
import 'package:granth_flutter/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileAllReviewListComponent extends StatelessWidget {
  final num? totalRatting;
  final int? bookId;

  final List<BookRatingData>? ratingList;

  final double? oneStarTotal;
  final double? twoStarTotal;
  final double? threeStarTotal;
  final double? fourStarTotal;
  final double? fiveStarTotal;

  MobileAllReviewListComponent({
    this.totalRatting,
    this.bookId,
    this.ratingList,
    this.oneStarTotal,
    this.twoStarTotal,
    this.threeStarTotal,
    this.fourStarTotal,
    this.fiveStarTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language!.reviews, elevation: 0),
      body: Stack(
        children: [
          if (!appStore.isLoading)
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      32.height,
                      TextIcon(
                        text: totalRatting!.toStringAsFixed(1).toDouble().toString().validate(),
                        textStyle: boldTextStyle(size: 48),
                        spacing: 4,
                        suffix: Icon(Icons.star, color: Colors.amber, size: 48),
                      ),
                      16.height,
                      ReviewTextComponent(label: '1', totalValue: oneStarTotal, color: poor),
                      4.height,
                      ReviewTextComponent(label: '2', totalValue: twoStarTotal, color: belowAverage),
                      4.height,
                      ReviewTextComponent(label: '3', totalValue: threeStarTotal, color: average),
                      4.height,
                      ReviewTextComponent(label: '4', totalValue: fourStarTotal, color: good),
                      4.height,
                      ReviewTextComponent(label: '5', totalValue: fiveStarTotal, color: excellent),
                      8.height
                    ],
                  ).paddingSymmetric(horizontal: 16),
                  16.height,
                  if (ratingList.validate().length != 0)
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
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
                    )
                  else
                    NoDataWidget(title: language!.noDataFound),
                ],
              ),
            )
          else
            AppLoaderWidget().center(),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:granth_flutter/component/price_component.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:nb_utils/nb_utils.dart';

class BookDetails1CategoryComponent extends StatelessWidget {
  final BookDetailResponse? bookDetailResponse;
  final bool? isCenterInfo;

  BookDetails1CategoryComponent({this.bookDetailResponse, this.isCenterInfo = false});

  @override
  Widget build(BuildContext context) {
    if (isWeb) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: isCenterInfo! ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            mainAxisAlignment: isCenterInfo! ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(language!.category, style: secondaryTextStyle()),
                  8.height,
                  Text(bookDetailResponse!.categoryName.validate(), style: boldTextStyle(), textAlign: TextAlign.center),
                ],
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(language!.category, style: secondaryTextStyle()),
                  8.height,
                  Text(bookDetailResponse!.categoryName.validate(), style: boldTextStyle(), textAlign: TextAlign.center),
                ],
              ).expand(),
            ],
          ),
        ],
      );
    }
  }
}

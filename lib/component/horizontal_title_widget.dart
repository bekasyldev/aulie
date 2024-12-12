import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:nb_utils/nb_utils.dart';

class HorizontalTitleWidget extends StatelessWidget {
  final String title;
  final Function()? onClick;
  bool? showSeeAll = true;
  bool? showClearAll = false;

  HorizontalTitleWidget(this.title, {this.onClick, this.showSeeAll, this.showClearAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title, style: boldTextStyle(size: 20, color: textPrimaryColorGlobal)),
        GestureDetector(
          onTap: onClick,
          child: showSeeAll.validate()
              ? Container(
                  decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text(showClearAll.validate() ? language!.clearAll : language!.seeAll, style: boldTextStyle(size: 14)),
                )
              : SizedBox(),
        )
      ],
    ).paddingOnly(left: 16, right: 16, top: 8);
  }
}

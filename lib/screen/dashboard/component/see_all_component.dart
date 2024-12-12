import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:nb_utils/nb_utils.dart';

class SeeAllComponent extends StatelessWidget {
  final String title;
  final VoidCallback? onClick;
  final String? trailingTitle;
  final bool isShowSeeAll;

  SeeAllComponent({required this.title, this.onClick, this.trailingTitle, this.isShowSeeAll = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(title, style: boldTextStyle(size: 20, color: textPrimaryColorGlobal)).expand(),
        if (isShowSeeAll)
          GestureDetector(
            onTap: onClick,
            child: Container(
              decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(trailingTitle ?? language!.seeAll, style: boldTextStyle(size: 14)),
            ),
          )
      ],
    );
  }
}

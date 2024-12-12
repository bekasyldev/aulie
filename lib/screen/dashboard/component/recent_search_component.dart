import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class RecentSearchComponent extends StatelessWidget {
  final Function? onRecentSearch;
  final bool isWebSearch;

  RecentSearchComponent({this.onRecentSearch, this.isWebSearch = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(language!.recentSearch, style: boldTextStyle(size: 16)),
        GestureDetector(
          child: Container(
            padding: isWebSearch ? EdgeInsets.all(8) : null,
            decoration: BoxDecoration(
              color: isWebSearch ? defaultPrimaryColor.withOpacity(0.2) : Colors.transparent,
              borderRadius: isWebSearch ? BorderRadius.all(Radius.circular(5)) : null,
            ),
            child: Text(language!.clearAll, style: primaryTextStyle(color: defaultPrimaryColor)),
          ),
          onTap: () {
            this.onRecentSearch?.call();
          },
        )
      ],
    );
  }
}

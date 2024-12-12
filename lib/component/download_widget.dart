import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class DownloadWidget extends StatelessWidget {
  final double? downloadPercentage;

  DownloadWidget({this.downloadPercentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(backgroundColor: defaultPrimaryColor.withOpacity(.8)),
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 120,
      width: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Loader(
            decoration: boxDecorationWithShadow(backgroundColor: context.cardColor, shadowColor: transparentColor, boxShape: BoxShape.circle),
          ),
          16.height,
          Text(language!.download, style: secondaryTextStyle(color: Colors.white)),
          8.width,
          Text('${downloadPercentage.validate().toStringAsFixed(0)} %', style: boldTextStyle(color: Colors.white)),
        ],
      ),
    ).center();
  }
}

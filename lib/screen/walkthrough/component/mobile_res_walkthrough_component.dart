import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileResWalkthroughComponent extends StatelessWidget {
  MobileResWalkthroughComponent({required this.mData});

  final WalkThroughModelClass mData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        120.height,
        Lottie.asset(mData.image.validate(), height: context.height() * 0.45, width: context.width()),
        30.height,
        Text(mData.subTitle.validate(), style: boldTextStyle(size: 24)),
        8.height,
        Text(mData.title.validate(), style: secondaryTextStyle(), softWrap: true)
      ],
    );
  }
}

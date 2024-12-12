import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class WebWalkthroughScreen extends StatelessWidget {
  final WalkThroughModelClass? mData;

  WebWalkthroughScreen({this.mData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: context.height() * 0.60,
            width: context.width() * 0.30,
            child: Lottie.asset(mData!.image.validate(), fit: BoxFit.contain, height: context.height(), width: context.width()),
          ),
          50.height,
          Text(mData!.subTitle.validate(), style: boldTextStyle(size: 24)),
          8.height,
          Text(mData!.title.validate(), style: secondaryTextStyle(), softWrap: true)
        ],
      ),
    );
  }
}

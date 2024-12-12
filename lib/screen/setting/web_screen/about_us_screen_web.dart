import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class WebAboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(app_logo, alignment: Alignment.center, height: 120, width: 120).cornerRadiusWithClipRRect(defaultRadius),
        16.height,
        Text('v$appVersion', style: primaryTextStyle()),
        16.height,
        Text(
          'We’ve moved on to our smartphones and tablets to read while we’re on the go. Granth is an flutter eBook '
          'application that takes your reading experience to the next level. You can read online as well as offline.'
          ' With its unique and eye-soothing color palette and design, Granth ensures the most engaging escapade for '
          'readers. This excellent app supports all major types of PDF files. The run-through is extremely easy providing'
          ' users ease to browse, look for his/her favourite author,'
          ' build a wishlist and read anywhere, anytime.',
          style: primaryTextStyle(),
          textAlign: TextAlign.justify,
        ),
        20.height,
        AppButton(
          text: language!.buyNow,
          color: defaultPrimaryColor,
          textStyle: primaryTextStyle(color: Colors.white),
          onTap: () {
            commonLaunchUrl(CodeCanyonLink);
          },
        ),
      ],
    );
  }
}

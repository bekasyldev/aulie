import 'package:flutter/material.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInBottomWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Function()? onTap;

  SignInBottomWidget({this.title, this.subTitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title!.validate(), style: secondaryTextStyle()),
        TextButton(
          onPressed: onTap,
          child: Text(subTitle.validate(), style: boldTextStyle(color: defaultPrimaryColor, size: 14)),
        )
      ],
    );
  }
}

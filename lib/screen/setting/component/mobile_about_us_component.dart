import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileAboutUsComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(app_logo, alignment: Alignment.center, height: 120, width: 120).cornerRadiusWithClipRRect(defaultRadius),
        16.height,
        Text(APP_NAME, style: boldTextStyle(size: 24,color: context.primaryColor)),
        16.height,
        VersionInfoWidget(prefixText: 'v'),
        16.height,
        Text(
          'Жамбыл облысы әкімдігінің қолдауымен жергілікті 24 қаламгердің кітабы жарық көрді. Мақсаты: өңір қаламгерлерінің еңбектерін, прозалық шығармалары мен жыр жинақтарын  таныстыру, жастарды кітап оқуға баулу, оқу мәдениетін қалыптастыру.',
          style: primaryTextStyle(),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

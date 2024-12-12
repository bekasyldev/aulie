import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/setting_screen_model.dart';
import 'package:granth_flutter/screen/setting/about_us_screen.dart';
import 'package:granth_flutter/screen/setting/feedback_screen.dart';
import 'package:granth_flutter/utils/colors.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingScreenBottomComponent extends StatefulWidget {
  static String tag = '/SettingScreenBottomComponent';

  @override
  SettingScreenBottomComponentState createState() => SettingScreenBottomComponentState();
}

class SettingScreenBottomComponentState extends State<SettingScreenBottomComponent> {
  List<SettingScreenModel> wrapWidgetListItem = [];

  @override
  void initState() {
    wrapWidgetListItem = wrapWidgetListData();
    super.initState();
  }

  List<SettingScreenModel> wrapWidgetListData() {
    List<SettingScreenModel> wrapWidgetListItem = [];

    wrapWidgetListItem.add(SettingScreenModel(
      image: terms_icon,
      key: TERMS_CONDITIONS,
      title: language!.termsConditions,
      onclick: () {
        toast(language!.termsConditions);
      },
    ));

    if (isMobile) {
      wrapWidgetListItem.add(
        SettingScreenModel(
            image: star_icon,
            key: RATE_US,
            title: language!.rateUs,
            onclick: () {
              toast(language!.rateUs);
            }),
      );
    }

    /* wrapWidgetListItem.add(
    SettingScreenModel(
        image: share_icon,
        key: SHARE_APP,
        title: language!.share,
        onclick: () {
          toast(language!.share);
        }),
  );*/
    wrapWidgetListItem.add(
      SettingScreenModel(
          image: feed_back,
          key: FEEDBACK,
          title: language!.feedback,
          onclick: () {
            toast(language!.feedback);
          }),
    );
    wrapWidgetListItem.add(
      SettingScreenModel(
          image: about_us_icon,
          key: ABOUT_APP,
          title: language!.aboutApp,
          onclick: () {
            toast(language!.aboutApp);
          }),
    );

    return wrapWidgetListItem;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 16,
      spacing: 8,
      direction: Axis.horizontal,
      children: wrapWidgetListItem.map((el) {
        return Column(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: secondaryPrimaryColor,
              child: Image.asset(el.image.validate(), height: 24, width: 24, fit: BoxFit.fitHeight),
            ),
            8.height,
            Container(
              width: 80,
              child: Text(
                el.title.validate(),
                softWrap: true,
                maxLines: 3,
                style: primaryTextStyle(color: whiteColor, size: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ).visible(el.key != FEEDBACK && el.key != RATE_US || appStore.isLoggedIn).onTap(() async {
          if (el.key == FEEDBACK) {
            FeedBackScreen().launch(context);
          } else if (el.key == TERMS_CONDITIONS) {
            await commonLaunchUrl(PRIVACY_POLICY);
          } else if (el.key == RATE_US) {
            getPackageName().then((value) {
              String package = '';
              if (isAndroid) package = value;

              commonLaunchUrl(
                '${isAndroid ? getSocialMediaLink(LinkProvider.PLAY_STORE) : getSocialMediaLink(LinkProvider.APPSTORE)}$package',
                launchMode: LaunchMode.externalApplication,
              );
            });
          } else if (el.key == ABOUT_APP) {
            AboutUsScreen().launch(context);
          }
        });
      }).toList(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/auth/change_password_screen.dart';
import 'package:granth_flutter/screen/auth/sign_in_screen.dart';
import 'package:granth_flutter/screen/setting/choose_detail_page_variant_screen.dart';
import 'package:granth_flutter/screen/setting/component/setting_screen_bottom_component.dart';
import 'package:granth_flutter/screen/setting/component/setting_top_component.dart';
import 'package:granth_flutter/screen/setting/language_screen.dart';
import 'package:granth_flutter/screen/setting/wishlist_screen.dart';
import 'package:granth_flutter/utils/colors.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';

class MobileSettingFragment extends StatefulWidget {
  @override
  _MobileSettingFragmentState createState() => _MobileSettingFragmentState();
}

class _MobileSettingFragmentState extends State<MobileSettingFragment> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  void share() async {
    getPackageInfo().then((value) {
      Share.share('Share $APP_NAME with your friends.\n\n${getSocialMediaLink(LinkProvider.PLAY_STORE)}${value.packageName}');
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        "",
        color: context.scaffoldBackgroundColor,
        elevation: 0,
        showBack: false,
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: defaultRadius),
            splashRadius: 24,
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              WishListScreen().launch(context);
            },
          ).visible(appStore.isLoggedIn),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: <Widget>[
                    SettingTopComponent().visible(appStore.isLoggedIn),
                    SettingItemWidget(
                      title: language!.login,
                      subTitle: language!.changeYourPassword,
                      onTap: () {
                        SignInScreen().launch(context);
                      },
                      trailing: IconButton(
                        padding: EdgeInsets.only(left: defaultRadius),
                        onPressed: () {},
                        icon: Icon(Icons.login),
                        splashColor: transparentColor,
                        highlightColor: transparentColor,
                      ),
                    ).visible(!appStore.isLoggedIn),
                    16.height.visible(appStore.isLoggedIn),
                    Divider(height: 0),
                    SettingItemWidget(
                      title: language!.changePassword,
                      subTitle: language!.changeYourPassword,
                      onTap: () {
                        ChangePasswordScreen().launch(context);
                      },
                      trailing: IconButton(
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.only(left: defaultRadius),
                        onPressed: () {},
                        splashColor: transparentColor,
                        highlightColor: transparentColor,
                        icon: Icon(Icons.password_rounded),
                      ),
                    ).visible(appStore.isLoggedIn),
                    Divider(height: 0).visible(appStore.isLoggedIn),
                    SettingItemWidget(
                      title: language!.appLanguage,
                      subTitle: language!.changeYourLanguage,
                      titleTextStyle: primaryTextStyle(weight: fontWeightBoldGlobal),
                      onTap: () async {
                        bool? hasLanguageChange = await LanguagesScreen().launch(context);
                        if (hasLanguageChange.validate()) {
                          setState(() {});
                        }
                      },
                      trailing: IconButton(
                        icon: Icon(Icons.language),
                        splashColor: transparentColor,
                        highlightColor: transparentColor,
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.only(left: defaultRadius),
                        onPressed: () async {
                          bool? hasLanguageChange = await LanguagesScreen().launch(context);
                          if (hasLanguageChange.validate()) {
                            setState(() {});
                          }
                        },
                      ),
                    ),
                    Divider(height: 0),
                    SettingItemWidget(
                      title: language!.appTheme,
                      subTitle: appStore.isDarkMode ? language!.tapToEnableLightMode : language!.tapToEnableDarkMode,
                      onTap: () async {
                        if (getBoolAsync(IS_DARK_MODE)) {
                          appStore.setDarkMode(false);
                          await setValue(IS_DARK_MODE, false);
                        } else {
                          appStore.setDarkMode(true);
                          await setValue(IS_DARK_MODE, true);
                        }
                      },
                      trailing: Container(
                        padding: EdgeInsets.only(left: defaultRadius),
                        height: 20,
                        width: 50,
                        child: Switch(
                          value: appStore.isDarkMode,
                          activeColor: defaultPrimaryColor,
                          activeTrackColor: grey.withOpacity(.6),
                          inactiveThumbColor: secondaryPrimaryColor,
                          inactiveTrackColor: grey.withOpacity(.6),
                          onChanged: (val) async {
                            appStore.setDarkMode(val);
                            await setValue(IS_DARK_MODE, val);
                          },
                        ),
                      ),
                    ),
                    Divider(height: 0),
                    SettingItemWidget(
                      title: language!.chooseDetailPageVariant,
                      subTitle: language!.animationMadeEvenBetter,
                      onTap: () {
                        ChooseDetailPageVariantScreen().launch(context);
                      },
                      trailing: IconButton(
                        constraints: BoxConstraints(),
                        padding: EdgeInsets.only(left: defaultRadius),
                        onPressed: () {},
                        splashColor: transparentColor,
                        highlightColor: transparentColor,
                        icon: Icon(Icons.check_circle_outline_outlined),
                      ),
                    ),
                    Divider(height: 0),
                    SettingItemWidget(
                      title: language!.share,
                      subTitle: language!.share,
                      trailing: Icon(Icons.share_rounded),
                      onTap: () {
                        share();
                      },
                    ),
                    Divider(height: 0).visible(appStore.isLoggedIn),
                    Spacer(),
                    Container(
                      color: defaultPrimaryColor.withOpacity(0.7),
                      padding: EdgeInsets.all(defaultRadius),
                      width: context.width(),
                      child: Column(
                        children: [
                          Image.asset(transparent_app_logo, height: 60, width: 60),
                          VersionInfoWidget(prefixText: "", textStyle: boldTextStyle(color: white)),
                          24.height,
                          SizedBox(
                            key: UniqueKey(),
                            child: SettingScreenBottomComponent(),
                          ),
                          16.height,
                          AppButton(
                            elevation: 0,
                            enableScaleAnimation: false,
                            shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: defaultPrimaryColor)),
                            width: context.width(),
                            color: white,
                            text: language!.logout,
                            textStyle: boldTextStyle(color: defaultPrimaryColor),
                            onTap: () async {
                              showConfirmDialogCustom(context, primaryColor: defaultPrimaryColor, onAccept: (c) {
                                logout(context);
                              }, title: language!.areYouSureWantToLogout, positiveText: language!.yes, negativeText: language!.no);
                            },
                          ).visible(appStore.isLoggedIn),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

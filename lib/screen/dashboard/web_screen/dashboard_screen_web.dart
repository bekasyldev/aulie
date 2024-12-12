import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/auth/change_password_screen.dart';
import 'package:granth_flutter/screen/auth/sign_in_screen.dart';
import 'package:granth_flutter/screen/dashboard/fragment/dashboard_fragment.dart';
import 'package:granth_flutter/screen/dashboard/fragment/library_fragment.dart';
import 'package:granth_flutter/screen/setting/language_screen.dart';
import 'package:granth_flutter/screen/setting/transaction_history_screen.dart';
import 'package:granth_flutter/screen/setting/web_screen/about_us_screen_web.dart';
import 'package:granth_flutter/screen/setting/web_screen/component/setting_top_component_web.dart';
import 'package:granth_flutter/screen/setting/web_screen/feedback_screen_web.dart';
import 'package:granth_flutter/screen/setting/wishlist_screen.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:granth_flutter/utils/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:share_plus/share_plus.dart';

class WebDashboardScreen extends StatefulWidget {
  @override
  _WebDashboardScreenState createState() => _WebDashboardScreenState();
}

class _WebDashboardScreenState extends State<WebDashboardScreen> {
  int initialPage = 0;

  List<Widget> pages = [
    DashboardFragment(),
    SignInScreen().visible(!appStore.isLoggedIn),
    LibraryFragment(),
    WishListScreen().visible(appStore.isLoggedIn),
    TransactionHistoryScreen().visible(appStore.isLoggedIn),
    ChangePasswordScreen().visible(appStore.isLoggedIn),
    LanguagesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    LiveStream().on("REFRESH_LANGUAGE", (p0) {
      setState(() {});
    });
    init();
  }

  void init() async {
    //
  }

  void share() {
    getPackageInfo().then((value) {
      Share.share('Share $APP_NAME with your friends.\n\n${getSocialMediaLink(LinkProvider.PLAY_STORE)}${value.packageName}');
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Color txtColor({int? index}) {
    return initialPage == index
        ? defaultPrimaryColor
        : appStore.isDarkMode
            ? Colors.white
            : Colors.black;
  }

  @override
  void dispose() {
    LiveStream().dispose("REFRESH_LANGUAGE");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        backgroundColor: appStore.isDarkMode ? Colors.black : Colors.white,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 260,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: context.width(),
                      color: defaultPrimaryColor.withOpacity(0.1),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(app_logo, height: 60, width: 60).cornerRadiusWithClipRRect(defaultRadius),
                              20.width,
                              Text('Granth', style: boldTextStyle(size: 24), maxLines: 2, overflow: TextOverflow.ellipsis),
                            ],
                          ).fit(),
                          20.height.visible(appStore.isLoggedIn),
                          WebSettingTopComponent().visible(appStore.isLoggedIn),
                        ],
                      ),
                    ),
                    25.height,
                    Column(
                      children: [
                        SettingItemWidget(
                          title: language!.dashboard,
                          titleTextStyle: boldTextStyle(size: 14, color: txtColor(index: 0)),
                          leading: home_icon.iconImage(color: txtColor(index: 0)),
                          onTap: () {
                            initialPage = 0;
                            setState(() {});
                          },
                        ),
                        SettingItemWidget(
                          title: language!.login,
                          titleTextStyle: boldTextStyle(size: 14, color: txtColor(index: 1)),
                          leading: Icon(Icons.login, color: txtColor(index: 1)),
                          onTap: () {
                            initialPage = 1;
                            setState(() {});
                          },
                        ).visible(!appStore.isLoggedIn),
                        SettingItemWidget(
                          title: language!.library,
                          titleTextStyle: boldTextStyle(size: 14, color: txtColor(index: 2)),
                          leading: library_icon2.iconImage(color: txtColor(index: 2)),
                          onTap: () {
                            initialPage = 2;
                            setState(() {});
                          },
                        ),
                        SettingItemWidget(
                          title: language!.myWishlist,
                          titleTextStyle: boldTextStyle(size: 14, color: txtColor(index: 3)),
                          leading: Icon(Icons.favorite_border, color: txtColor(index: 3)),
                          onTap: () {
                            initialPage = 3;
                            setState(() {});
                          },
                        ).visible(appStore.isLoggedIn),
                        SettingItemWidget(
                          title: language!.transactionHistory,
                          titleTextStyle: boldTextStyle(size: 14, color: txtColor(index: 4)),
                          leading: Icon(Icons.monetization_on_outlined, color: txtColor(index: 4)),
                          onTap: () {
                            initialPage = 4;
                            setState(() {});
                          },
                        ).visible(appStore.isLoggedIn),
                        SettingItemWidget(
                          title: language!.changePassword,
                          titleTextStyle: boldTextStyle(size: 14, color: txtColor(index: 5)),
                          leading: Icon(Icons.password_rounded, color: txtColor(index: 5)),
                          onTap: () {
                            initialPage = 5;
                            setState(() {});
                          },
                        ).visible(appStore.isLoggedIn),
                        SettingItemWidget(
                          title: language!.appLanguage,
                          titleTextStyle: boldTextStyle(size: 14, color: txtColor(index: 6)),
                          leading: Icon(Icons.language, color: txtColor(index: 6)),
                          onTap: () {
                            initialPage = 6;
                            setState(() {});
                            if (initialPage == 6) {
                              setState(() {});
                            }
                          },
                        ),
                        SettingItemWidget(
                          title: language!.appTheme,
                          titleTextStyle: boldTextStyle(size: 14),
                          leading: Icon(appStore.isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
                          onTap: () async {
                            if (getBoolAsync(IS_DARK_MODE)) {
                              appStore.setDarkMode(false);
                              await setValue(IS_DARK_MODE, false);
                            } else {
                              appStore.setDarkMode(true);
                              await setValue(IS_DARK_MODE, true);
                            }
                          },
                          trailing: SizedBox(
                            height: 15,
                            width: 40,
                            child: CupertinoSwitch(
                              value: appStore.isDarkMode,
                              thumbColor: Colors.white,
                              trackColor: grey.withOpacity(.6),
                              activeColor: defaultPrimaryColor,
                              onChanged: (val) async {
                                appStore.setDarkMode(val);
                                await setValue(IS_DARK_MODE, val);
                              },
                            ).scale(scale: 0.7),
                          ),
                        ),
                        SettingItemWidget(
                          title: language!.share,
                          titleTextStyle: boldTextStyle(size: 14),
                          leading: Icon(Icons.share_rounded),
                          onTap: () {
                            share();
                          },
                        ),
                        SettingItemWidget(
                          title: language!.termsConditions,
                          titleTextStyle: boldTextStyle(size: 14),
                          leading: terms_icon.iconImage(color: appStore.isDarkMode ? Colors.white : Colors.black),
                          onTap: () async {
                            await commonLaunchUrl(PRIVACY_POLICY);
                          },
                        ),
                        SettingItemWidget(
                          title: language!.feedback,
                          titleTextStyle: boldTextStyle(size: 14),
                          leading: feed_back.iconImage(color: appStore.isDarkMode ? Colors.white : Colors.black),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return customDialogue(context, child: WebFeedbackScreen(), title: language!.feedback);
                              },
                            );
                          },
                        ).visible(appStore.isLoggedIn),
                        SettingItemWidget(
                          title: language!.aboutApp,
                          titleTextStyle: boldTextStyle(size: 14),
                          leading: about_us_icon.iconImage(color: appStore.isDarkMode ? Colors.white : Colors.black),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return customDialogue(context, child: WebAboutUsScreen(), title: language!.aboutApp);
                              },
                            );
                          },
                        ),
                        10.height,
                        AppButton(
                          elevation: 0,
                          enableScaleAnimation: false,
                          shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: defaultPrimaryColor)),
                          width: context.width(),
                          color: white,
                          text: language!.logout,
                          textStyle: boldTextStyle(color: defaultPrimaryColor),
                          onTap: () async {
                            showConfirmDialogCustom(
                              context,
                              primaryColor: defaultPrimaryColor,
                              title: language!.areYouSureWantToLogout,
                              positiveText: language!.yes,
                              negativeText: language!.no,
                              onAccept: (c) {
                                logout(context);
                              },
                            );
                          },
                        ).visible(appStore.isLoggedIn).paddingAll(16),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Scaffold(
              body: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: pages[initialPage],
              ),
            ).expand(flex: 9),
          ],
        ),
      );
    });
  }
}

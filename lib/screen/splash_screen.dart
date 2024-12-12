import 'package:flutter/material.dart';
import 'package:granth_flutter/screen/dashboard/dashboard_screen.dart';
import 'package:granth_flutter/screen/walkthrough/walkthrough_screen.dart';
import 'package:granth_flutter/utils/colors.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../configs.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(transparentColor, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark);
    await 1.seconds.delay;

    if (isMobile) {
      if (getBoolAsync(FIRST_TIME, defaultValue: true)) {
        WalkThroughScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
      } else {
        DashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
      }
    } else {
      DashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryPrimaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(app_logo, height: 120, width: 120, fit: BoxFit.cover).cornerRadiusWithClipRRect(defaultRadius),
          32.height,
          Text(APP_NAME, style: boldTextStyle(size: 26,color: context.primaryColor)),
        ],
      ).center(),
    );
  }
}

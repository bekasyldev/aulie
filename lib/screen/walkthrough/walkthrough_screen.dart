import 'package:flutter/material.dart';
import 'package:granth_flutter/component/app_scroll_behaviour.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/screen/dashboard/dashboard_screen.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/screen/walkthrough/component/mobile_res_walkthrough_component.dart';
import 'package:granth_flutter/screen/walkthrough/walkthrough_screen_web.dart';
import 'package:granth_flutter/utils/colors.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/dots_indicator.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class WalkThroughScreen extends StatefulWidget {
  static String tag = '/WalkThroughScreen';

  @override
  WalkThroughScreenState createState() => WalkThroughScreenState();
}

class WalkThroughScreenState extends State<WalkThroughScreen> {
  PageController pageController = PageController(initialPage: 0);

  List<WalkThroughModelClass> pages = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    pages.add(WalkThroughModelClass(subTitle: language!.youCanReadBooksEasily, image: walk_through_1, title: language!.readBookAnywhere));
    pages.add(WalkThroughModelClass(subTitle: language!.youCanDownloadBooks, image: walk_through_2, title: language!.downloadBooks));
    pages.add(WalkThroughModelClass(title: language!.youCanReadBooks, image: walk_through_3, subTitle: language!.offlineBookRead));

    setStatusBarColor(transparentColor, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryPrimaryColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            scrollBehavior: AppScrollBehavior(),
            controller: pageController,
            itemCount: pages.length,
            onPageChanged: (index) {
              currentIndex = index;
              setState(() {});
            },
            itemBuilder: (BuildContext context, int index) {
              WalkThroughModelClass mData = pages[index];
              return Responsive(
                mobile: MobileResWalkthroughComponent(mData: mData).paddingSymmetric(horizontal: 16),
                web: WebWalkthroughScreen(mData: mData).paddingSymmetric(horizontal: 16),
                tablet: WebWalkthroughScreen(mData: mData).paddingSymmetric(horizontal: 16),
              );
            },
          ),
          Positioned(
            bottom: 40,
            left: 30,
            child: DotsIndicator(
              controller: pageController,
              itemCount: pages.length,
              currentIndex: currentIndex,
              activeText: whiteColor,
              deActiveText: blackColor,
              color: defaultPrimaryColor,
              length: 22,
              colorDisable: grey.withOpacity(.1),
              isCircle: true,
              onPageSelected: (int value) {
                //
              },
            ),
          ),
          Positioned(
            bottom: 26,
            right: 30,
            child: AppButton(
              enableScaleAnimation: false,
              color: defaultPrimaryColor,
              text: currentIndex == 2 ? language!.getStarted : language!.next,
              textStyle: boldTextStyle(color: whiteColor),
              onTap: () async {
                if (currentIndex == 2) {
                  await setValue(FIRST_TIME, false);
                  DashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
                } else {
                  pageController.nextPage(duration: 500.milliseconds, curve: Curves.linearToEaseOut);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/dashboard_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/dashboard/fragment/mobile_dashboard_fragment.dart';
import 'package:granth_flutter/screen/dashboard/fragment/web_fragment/dashboard_fragment_web.dart';
import 'package:granth_flutter/screen/dashboard/search_screen.dart';
import 'package:granth_flutter/utils/colors.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardFragment extends StatefulWidget {
  static String tag = '/DashboardScreen';

  @override
  DashboardFragmentState createState() => DashboardFragmentState();
}

class DashboardFragmentState extends State<DashboardFragment> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    afterBuildCreated(() {
      setStatusBarColor(transparentColor, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: appBarWidget(
        language!.dashboard,
        titleTextStyle: boldTextStyle(size: 24),
        showBack: false,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              SearchScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        color: secondaryPrimaryColor,
        backgroundColor: defaultPrimaryColor,
        onRefresh: () async {
          setState(() {});
          return await 2.seconds.delay;
        },
        child: SnapHelperWidget<DashboardResponse>(
          future: getDashboardDetails(),
          onSuccess: (data) {
            return Responsive(
              mobile: MobileDashboardFragment(data: data),
              web: WebDashboardFragment(data: data),
              tablet: MobileDashboardFragment(data: data),
            );
          },
          loadingWidget: AppLoaderWidget().center(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/screen/auth/sign_in_screen.dart';
import 'package:granth_flutter/screen/dashboard/fragment/dashboard_fragment.dart';
import 'package:granth_flutter/screen/dashboard/fragment/library_fragment.dart';
import 'package:granth_flutter/screen/dashboard/fragment/setting_fragment.dart';
import 'package:granth_flutter/utils/colors.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:granth_flutter/utils/string_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileDashboardScreen extends StatefulWidget {
  @override
  _MobileDashboardScreenState createState() => _MobileDashboardScreenState();
}

class _MobileDashboardScreenState extends State<MobileDashboardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        backgroundColor: secondaryPrimaryColor,
        body: [
          DashboardFragment(),
          LibraryFragment(),
          SettingFragment(),
        ][appStore.bottomNavigationBarIndex],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: !appStore.isDarkMode ? defaultPrimaryColor.withOpacity(0.8) : null,
            backgroundColor: !appStore.isDarkMode ? defaultPrimaryColor.withOpacity(0.05) : null,
            labelTextStyle: MaterialStateProperty.all(const TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          child: NavigationBar(
            selectedIndex: appStore.bottomNavigationBarIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            height: 60,
            destinations: [
              NavigationDestination(
                icon: home_icon.iconImage(color: appTextSecondaryColor),
                selectedIcon: home_icon1.iconImage(color: white),
                label: language!.dashboard,
              ),
              NavigationDestination(
                icon: library_icon2.iconImage(color: appTextSecondaryColor),
                selectedIcon: library_icon1.iconImage(color: white),
                label: language!.library,
              ),
              NavigationDestination(
                icon: setting_icon.iconImage(color: appTextSecondaryColor),
                selectedIcon: setting_icon1.iconImage(color: white),
                label: language!.profile,
              ),
            ],
            onDestinationSelected: (index) {
              appStore.bottomNavigationBarIndex = index;
              if (index == 1) {
                LiveStream().emit(REFRESH_lIBRARY_LIST);
              }
              setState(() {});
            },
          ),
        ),
      );
    });
  }
}

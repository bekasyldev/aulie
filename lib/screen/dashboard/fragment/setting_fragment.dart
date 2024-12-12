import 'package:flutter/material.dart';
import 'package:granth_flutter/screen/dashboard/fragment/mobile_setting_fragment.dart';
import 'package:nb_utils/nb_utils.dart';

class SettingFragment extends StatefulWidget {
  static String tag = '/SettingScreen';

  @override
  SettingFragmentState createState() => SettingFragmentState();
}

class SettingFragmentState extends State<SettingFragment> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    afterBuildCreated(() async {
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
      body: Responsive(
        mobile: MobileSettingFragment(),
        tablet: MobileSettingFragment(),
      ),
    );
  }
}

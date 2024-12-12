import 'package:flutter/material.dart';
import 'package:granth_flutter/screen/setting/component/mobile_choose_detail_page_variant_component.dart';
import 'package:granth_flutter/screen/setting/web_screen/choose_detail_page_variant_screen_web.dart';
import 'package:nb_utils/nb_utils.dart';

class ChooseDetailPageVariantScreen extends StatefulWidget {
  static String tag = '/ChooseDetailPageScreen';

  @override
  ChooseDetailPageVariantScreenState createState() => ChooseDetailPageVariantScreenState();
}

class ChooseDetailPageVariantScreenState extends State<ChooseDetailPageVariantScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    afterBuildCreated(() async {
      await setStatusBarColor(transparentColor, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark);
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
        mobile: MobileChooseDetailPageVariantComponent().paddingSymmetric(horizontal: 8),
        web: WebChooseDetailPageVariantScreen(),
        tablet: MobileChooseDetailPageVariantComponent().paddingSymmetric(horizontal: 8),
      ),
    );
  }
}

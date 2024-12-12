import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/screen/setting/component/mobile_about_us_component.dart';
import 'package:granth_flutter/screen/setting/web_screen/about_us_screen_web.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/utils/admob_utils.dart';
import 'package:nb_utils/nb_utils.dart';

class AboutUsScreen extends StatefulWidget {
  static String tag = '/AboutUsScreen';

  @override
  AboutUsScreenState createState() => AboutUsScreenState();
}

class AboutUsScreenState extends State<AboutUsScreen> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (isMobile) {
      _bannerAd = createBannerAd()..load();
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language!.aboutUs, elevation: 0),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Responsive(
              mobile: MobileAboutUsComponent(),
              web: WebAboutUsScreen(),
              tablet: MobileAboutUsComponent(),
            ),
          ),
          (_bannerAd != null && ENABLE_ADMOB)
              ? Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AdWidget(ad: _bannerAd!).withWidth(AdSize.banner.width.toDouble()).withHeight(AdSize.banner.height.toDouble()),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

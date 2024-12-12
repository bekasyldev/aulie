import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/screen/setting/component/mobile_feedback_component.dart';
import 'package:granth_flutter/screen/setting/web_screen/feedback_screen_web.dart';
import 'package:nb_utils/nb_utils.dart';

class FeedBackScreen extends StatefulWidget {
  static String tag = '/FeedBackScreen';

  @override
  FeedBackScreenState createState() => FeedBackScreenState();
}

class FeedBackScreenState extends State<FeedBackScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
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
      body: Stack(
        children: [
          Responsive(
            mobile: MobileFeedbackComponent(),
            web: WebFeedbackScreen(),
            tablet: MobileFeedbackComponent(),
          ),
          Observer(
            builder: (context) {
              return AppLoaderWidget().center().visible(appStore.isLoading);
            },
          )
        ],
      ),
    );
  }
}

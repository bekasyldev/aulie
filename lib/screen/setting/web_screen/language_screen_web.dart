import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class WebLanguageScreen extends StatefulWidget {
  @override
  _WebLanguageScreenState createState() => _WebLanguageScreenState();
}

class _WebLanguageScreenState extends State<WebLanguageScreen> {
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
        appBar: appBarWidget('', showBack: false, elevation: 0, color: context.dividerColor.withOpacity(0.1)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              WebBreadCrumbWidget(context, title: language!.language, subTitle1: 'Home', subTitle2: language!.appLanguage),
              Observer(builder: (context) {
                return Container(
                  width: context.width() * 0.45,
                  decoration: boxDecorationDefault(boxShadow: [BoxShadow(color: Colors.transparent)], color: appStore.isDarkMode ? scaffoldDarkColor : Colors.white),
                  child: LanguageListWidget(
                    widgetType: WidgetType.LIST,
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    trailing: Container(
                      padding: EdgeInsets.all(2),
                      decoration: boxDecorationDefault(color: defaultPrimaryColor, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.transparent)]),
                      child: Icon(Icons.check, size: 15, color: white),
                    ),
                    onLanguageChange: (v) {
                      appStore.setLanguage(v.languageCode!);
                      LiveStream().emit("REFRESH_LANGUAGE");
                      finish(context, true);
                    },
                  ),
                ).paddingBottom(16);
              }),
            ],
          ),
        ),
      );
    });
  }
}

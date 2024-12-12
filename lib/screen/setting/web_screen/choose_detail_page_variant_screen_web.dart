import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/screen/setting/component/choose_page_component.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class WebChooseDetailPageVariantScreen extends StatelessWidget {
  const WebChooseDetailPageVariantScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: appBarWidget('', showBack: false, elevation: 0, color: context.dividerColor.withOpacity(0.1)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              WebBreadCrumbWidget(context, title: language!.chooseDetailPageVariant, subTitle1: 'Home', subTitle2: language!.chooseDetailPageVariant),
              SizedBox(
                width: context.width() * 0.6,
                child: Row(
                  children: [
                    ChoosePageComponent(
                      image: web_page_variant1,
                      pageType: 1,
                      isWebPage: true,
                      onTap: () {
                        appStore.setPageVariant(1);
                      },
                    ).expand(),
                    22.width,
                    ChoosePageComponent(
                      image: web_page_variant2,
                      pageType: 2,
                      isWebPage: true,
                      onTap: () {
                        appStore.setPageVariant(2);
                      },
                    ).expand(),
                  ],
                ),
              ).center(),
            ],
          ),
        ),
      );
    });
  }
}

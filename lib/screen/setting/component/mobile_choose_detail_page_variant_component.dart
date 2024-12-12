import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/screen/setting/component/choose_page_component.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileChooseDetailPageVariantComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language!.chooseDetailPageVariant, elevation: 0),
      body: Row(
        children: [
          ChoosePageComponent(
            image: choose_page_variant1,
            pageType: 1,
            onTap: () {
              appStore.setPageVariant(1);
            },
          ).expand(),
          8.width,
          ChoosePageComponent(
            image: choose_page_variant2,
            pageType: 2,
            onTap: () {
              appStore.setPageVariant(2);
            },
          ).expand()
        ],
      ),
    );
  }
}

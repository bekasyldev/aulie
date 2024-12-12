import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class ChoosePageComponent extends StatefulWidget {
  static String tag = '/ChoosePageComponent';
  final int? pageType;
  final String? image;
  final Function? onTap;
  final bool isWebPage;

  ChoosePageComponent({this.pageType, this.onTap, this.image, this.isWebPage = false});

  @override
  ChoosePageComponentState createState() => ChoosePageComponentState();
}

class ChoosePageComponentState extends State<ChoosePageComponent> {
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
    return Observer(
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: boxDecorationWithRoundedCorners(border: Border.all(color: appStore.pageVariant == widget.pageType ? defaultPrimaryColor : transparentColor, width: 2)),
                  height: 320,
                  child: Image.asset(
                    widget.image.validate(),
                    width: context.width(),
                    fit: widget.isWebPage ? BoxFit.fill : BoxFit.fitWidth,
                  ).cornerRadiusWithClipRRect(defaultRadius),
                ),
                Container(decoration: boxDecorationWithRoundedCorners(backgroundColor: appStore.pageVariant == widget.pageType ? Colors.black12 : transparentColor), height: 320),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    height: 32,
                    width: 32,
                    child: Icon(Icons.check, color: defaultPrimaryColor),
                    decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
                  ),
                ).visible(appStore.pageVariant == widget.pageType)
              ],
            ).onTap(
              () {
                widget.onTap?.call();
              },
            )
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/font_size_model.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class FontSizeComponent extends StatefulWidget {
  static String tag = '/test';
  final List<FontSizeModel>? fontSizeList;
  final int? selectedIndex;
  final Function? onTap;

  FontSizeComponent({this.fontSizeList, this.selectedIndex, this.onTap});

  @override
  FontSizeComponentState createState() => FontSizeComponentState();
}

class FontSizeComponentState extends State<FontSizeComponent> {
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
    return Container(
      color: context.cardColor,
      height: context.height() * 0.45,
      padding: EdgeInsets.only(bottom: 32, top: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(child: Text(language!.fontSize, style: boldTextStyle())),
          32.height,
          ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(height: 0);
            },
            itemCount: widget.fontSizeList!.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            primary: false,
            itemBuilder: (context, index) {
              FontSizeModel mData = widget.fontSizeList![index];
              return Row(
                children: [
                  Text(mData.fontName.validate(), style: secondaryTextStyle(), textAlign: TextAlign.center).expand(),
                  32.width,
                  Text(
                    mData.fontSize.toString(),
                    style: primaryTextStyle(
                        color: widget.selectedIndex == index
                            ? defaultPrimaryColor
                            : appStore.isDarkMode
                                ? white
                                : black),
                    textAlign: TextAlign.center,
                  ).paddingOnly(right: 32)
                ],
              ).paddingAll(8).onTap(() {
                widget.onTap?.call(index);
              });
            },
          ),
          16.height,
          ElevatedButton(
            onPressed: () {
              finish(context, true);
            },
            child: Text(language!.set, style: primaryTextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(backgroundColor: defaultPrimaryColor),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:granth_flutter/models/category_list_model.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryListComponent extends StatefulWidget {
  static String tag = '/Category';
  final Category? mData;
  final bool? isTransparentBg;

  CategoryListComponent({this.mData, this.isTransparentBg = false});

  @override
  CategoryListComponentState createState() => CategoryListComponentState();
}

class CategoryListComponentState extends State<CategoryListComponent> {
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
      padding: EdgeInsets.all(defaultRadius),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: widget.isTransparentBg! ? context.cardColor.withOpacity(0.8) : context.cardColor,
        boxShadow: defaultBoxShadow(shadowColor: grey.withOpacity(0.2), spreadRadius: 0.5, offset: Offset(0.3, 0.2), blurRadius: 1),
      ),
      alignment: Alignment.center,
      width: (context.width() / 2) - 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: defaultPrimaryColor.withOpacity(0.5),
            child: Text(widget.mData!.name.validate().substring(0, 1).capitalizeFirstLetter(), style: boldTextStyle(color: whiteColor)),
          ),
          8.height,
          Text(widget.mData!.name.validate(), style: boldTextStyle(), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2)
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:granth_flutter/models/category_model.dart';
import 'package:granth_flutter/screen/dashboard/category_wise_book_screen.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryComponent extends StatefulWidget {
  static String tag = '/CategoryListComponent';
  final List<CategoryBookResponse>? categoryBookList;

  CategoryComponent({this.categoryBookList});

  @override
  CategoryComponentState createState() => CategoryComponentState();
}

class CategoryComponentState extends State<CategoryComponent> {
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
    if (isWeb) {
      return Wrap(
        spacing: 15,
        runSpacing: 15,
        children: List.generate(widget.categoryBookList!.length.validate(), (index) {
          CategoryBookResponse mData = widget.categoryBookList![index];
          return Material(
            color: context.scaffoldBackgroundColor,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
              onTap: () {
                CategoryWiseBookScreen(categoryId: mData.categoryId).launch(context);
              },
              child: Container(
                decoration: boxDecorationWithRoundedCorners(backgroundColor: transparentColor, border: Border.all(color: defaultPrimaryColor)),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(mData.categoryName.validate(), style: boldTextStyle(color: defaultPrimaryColor, size: 14), textAlign: TextAlign.start, maxLines: 1),
              ),
            ),
          );
        }),
      ).paddingSymmetric(horizontal: 16);
    } else {
      return HorizontalList(
        runSpacing: 0,
        spacing: 16,
        itemCount: widget.categoryBookList!.length.validate(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (BuildContext context, int index) {
          CategoryBookResponse mData = widget.categoryBookList![index];
          return Material(
            color: context.scaffoldBackgroundColor,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
              onTap: () {
                CategoryWiseBookScreen(categoryId: mData.categoryId).launch(context);
              },
              child: Container(
                decoration: boxDecorationWithRoundedCorners(backgroundColor: transparentColor, border: Border.all(color: defaultPrimaryColor)),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Text(mData.categoryName.validate(), style: boldTextStyle(color: defaultPrimaryColor, size: 14), textAlign: TextAlign.start, maxLines: 1),
              ),
            ),
          );
        },
      );
    }
  }
}

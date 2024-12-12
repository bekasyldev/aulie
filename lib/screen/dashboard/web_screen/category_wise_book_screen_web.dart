import 'package:flutter/material.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/screen/book/component/book_component.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class WebCategoryWiseBookScreen extends StatelessWidget {
  final List<BookDetailResponse>? categoryWiseBookData;
  final double? width;
  final String? subCategoryName;

  WebCategoryWiseBookScreen({this.categoryWiseBookData, this.width, this.subCategoryName});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          WebBreadCrumbWidget(
            context,
            title: language!.category,
            subTitle1: 'Name',
            subTitle2: subCategoryName != ALL_BOOK ? subCategoryName : categoryWiseBookData!.first.categoryName,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: context.width() * 0.8, minWidth: context.width() * 0.8),
            child: Wrap(
              spacing: 22,
              runSpacing: 22,
              children: List.generate(categoryWiseBookData.validate().length, (index) {
                BookDetailResponse? mData = categoryWiseBookData.validate()[index];
                return Container(
                  width: width,
                  padding: EdgeInsets.all(16),
                  decoration: boxDecorationDefault(boxShadow: [BoxShadow(color: Colors.transparent)], color: defaultPrimaryColor.withOpacity(0.1)),
                  child: BookComponent(bookData: mData, isCenterBookInfo: true, isLeftDisTag: 70),
                );
              }),
            ),
          ).paddingBottom(16),
        ],
      ),
    );
  }
}

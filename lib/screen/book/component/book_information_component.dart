import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/all_book_details_model.dart';
import 'package:nb_utils/nb_utils.dart';

class BooksInformationComponent extends StatefulWidget {
  static String tag = '/OverViewComponent';
  final AllBookDetailsModel? allBookDetailsModel;

  BooksInformationComponent({this.allBookDetailsModel});

  @override
  BooksInformationComponentState createState() => BooksInformationComponentState();
}

class BooksInformationComponentState extends State<BooksInformationComponent> {
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
      decoration: BoxDecoration(border: Border.all(width: 1, color: context.dividerColor), borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          if (widget.allBookDetailsModel!.bookDetailResponse!.first.categoryName!.isNotEmpty)
            SettingItemWidget(
              titleTextStyle: secondaryTextStyle(),
              title: language!.category,
              trailing: Text(widget.allBookDetailsModel!.bookDetailResponse!.first.categoryName.validate(), style: primaryTextStyle(), overflow: TextOverflow.ellipsis),
            ),
          Divider(),
          if (widget.allBookDetailsModel!.bookDetailResponse!.first.dateOfPublication!.isNotEmpty)
            SettingItemWidget(
              titleTextStyle: secondaryTextStyle(),
              title: language!.created,
              trailing: Text(widget.allBookDetailsModel!.bookDetailResponse!.first.dateOfPublication.validate(), style: primaryTextStyle(), overflow: TextOverflow.ellipsis),
            ),
          Divider(),
          if (widget.allBookDetailsModel!.authorDetail!.first.name!.isNotEmpty)
            SettingItemWidget(
              titleTextStyle: secondaryTextStyle(),
              title: language!.authors,
              trailing: Text(widget.allBookDetailsModel!.authorDetail!.first.name.validate(), style: primaryTextStyle(), overflow: TextOverflow.ellipsis),
            ),
          Divider(),
          if (widget.allBookDetailsModel!.authorDetail!.first.designation!.isNotEmpty)
            SettingItemWidget(
              titleTextStyle: secondaryTextStyle(),
              title: language!.designation,
              trailing: Text(widget.allBookDetailsModel!.authorDetail!.first.designation.validate(), style: primaryTextStyle(), overflow: TextOverflow.ellipsis),
            ),
          Divider(),
          if (widget.allBookDetailsModel!.bookDetailResponse!.first.publisher!.isNotEmpty)
            SettingItemWidget(
              titleTextStyle: secondaryTextStyle(),
              title: language!.publisher,
              trailing: Text(widget.allBookDetailsModel!.bookDetailResponse!.first.publisher.validate(), style: primaryTextStyle(), overflow: TextOverflow.ellipsis),
            ),
          Divider(),
          if (widget.allBookDetailsModel!.bookDetailResponse!.first.language!.isNotEmpty)
            SettingItemWidget(
              titleTextStyle: secondaryTextStyle(),
              title: language!.language,
              trailing: Text(widget.allBookDetailsModel!.bookDetailResponse!.first.language.validate(), style: primaryTextStyle(), overflow: TextOverflow.ellipsis),
            ),
          Divider(),
          if (widget.allBookDetailsModel!.bookDetailResponse!.first.format!.isNotEmpty)
            SettingItemWidget(
              titleTextStyle: secondaryTextStyle(),
              title: language!.availableFormat,
              trailing: Text(widget.allBookDetailsModel!.bookDetailResponse!.first.format.validate(), style: primaryTextStyle(), overflow: TextOverflow.ellipsis),
            ),
          if (widget.allBookDetailsModel!.bookDetailResponse!.first.totalPage != null) Divider(),
          if (widget.allBookDetailsModel!.bookDetailResponse!.first.totalPage != null)
            SettingItemWidget(
              titleTextStyle: secondaryTextStyle(),
              title: language!.totalPage,
              trailing: Text(widget.allBookDetailsModel!.bookDetailResponse!.first.totalPage.validate().toString(), style: primaryTextStyle(), overflow: TextOverflow.ellipsis),
            ),
        ],
      ),
    );
  }
}

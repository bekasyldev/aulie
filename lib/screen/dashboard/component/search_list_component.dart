import 'package:flutter/material.dart';
import 'package:granth_flutter/component/cache_image_widget.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/screen/book/book_details_screen1.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchListBookComponent extends StatefulWidget {
  static String tag = '/ SearchListBookComponent';
  final BookDetailResponse? mData;

  SearchListBookComponent({required this.mData});

  @override
  SearchListBookComponentState createState() => SearchListBookComponentState();
}

class SearchListBookComponentState extends State<SearchListBookComponent> {
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
      width: context.width() * 0.5 - 24,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedImageWidget(
            url: widget.mData!.frontCover.validate(),
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ).cornerRadiusWithClipRRect(defaultRadius),
          8.width,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.mData!.name.validate(), style: boldTextStyle(size: 14), overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.start),
              8.height,
              Text(widget.mData!.authorName.validate(), style: primaryTextStyle(size: 12), textAlign: TextAlign.start),
            ],
          ).expand(),
        ],
      ),
    ).onTap(
      () {
        BookDetailsScreen1(bookDetailResponse: widget.mData).launch(context);
      },
    );
  }
}

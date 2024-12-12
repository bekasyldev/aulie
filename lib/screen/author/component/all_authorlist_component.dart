import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/author_model.dart';
import 'package:granth_flutter/component/cache_image_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class AllAuthorListComponent extends StatefulWidget {
  static String tag = '/AllAuthorListComponent';
  final AuthorResponse? authorData;
  final bool? isWebAuthor;

  AllAuthorListComponent({this.authorData, this.isWebAuthor = false});

  @override
  AllAuthorListComponentState createState() => AllAuthorListComponentState();
}

class AllAuthorListComponentState extends State<AllAuthorListComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isWebAuthor!) {
      return Container(
        width: context.width() * 0.4,
        padding: EdgeInsets.all(defaultRadius),
        decoration: boxDecorationWithRoundedCorners(
          backgroundColor: context.cardColor,
          boxShadow: defaultBoxShadow(shadowColor: grey.withOpacity(0.2), spreadRadius: 0.5, offset: Offset(0.3, 0.2), blurRadius: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImageWidget(url: widget.authorData!.image.validate(), height: 80, width: 80, fit: BoxFit.cover, circle: true),
            10.height,
            if (widget.authorData!.designation!.isNotEmpty) Text(widget.authorData!.designation!.validate(), style: primaryTextStyle()),
            Marquee(
              child: Text(
                widget.authorData!.name.capitalizeFirstLetter().validate(),
                style: boldTextStyle(size: 18),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            if (widget.authorData!.address!.isNotEmpty) 4.height,
            if (widget.authorData!.address!.isNotEmpty) Text(widget.authorData!.address.validate(), style: secondaryTextStyle(), overflow: TextOverflow.ellipsis, maxLines: 2),
          ],
        ),
      );
    } else {
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 40),
            width: (context.width()),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: context.cardColor,
              boxShadow: defaultBoxShadow(shadowColor: grey.withOpacity(0.2), spreadRadius: 0.5, offset: Offset(0.3, 0.2), blurRadius: 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Marquee(
                  child: Text(
                    widget.authorData!.name.capitalizeFirstLetter().validate(),
                    style: boldTextStyle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                if (widget.authorData!.address!.isNotEmpty) 4.height,
                if (widget.authorData!.address!.isNotEmpty)
                  Text(
                    widget.authorData!.address.validate(),
                    style: secondaryTextStyle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                8.height,
                Text(language!.designation, style: secondaryTextStyle(size: 12)),
                if (widget.authorData!.designation!.isNotEmpty) 4.height,
                if (widget.authorData!.designation!.isNotEmpty) Text(widget.authorData!.designation!.validate(), style: primaryTextStyle()),
              ],
            ).paddingOnly(top: 16, left: 56, right: 16, bottom: 16),
          ),
          Positioned(
            left: 0,
            child: CachedImageWidget(
              url: widget.authorData!.image.validate(),
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ).cornerRadiusWithClipRRect(defaultRadius),
          )
        ],
      );
    }
  }
}

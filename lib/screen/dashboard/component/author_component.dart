import 'package:flutter/material.dart';
import 'package:granth_flutter/models/author_model.dart';
import 'package:granth_flutter/screen/author/author_details_screen.dart';
import 'package:granth_flutter/component/cache_image_widget.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthorComponent extends StatefulWidget {
  static String tag = '/AuthorListComponent';
  final AuthorResponse? authorData;

  AuthorComponent({this.authorData});

  @override
  AuthorComponentState createState() => AuthorComponentState();
}

class AuthorComponentState extends State<AuthorComponent> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              width: 70,
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
              decoration: boxDecorationWithRoundedCorners(
                border: Border.all(color: defaultPrimaryColor, width: 2),
                borderRadius: radius(defaultRadius),
              ),
              child: CachedImageWidget(
                url: widget.authorData!.image.validate(),
                height: 85,
                fit: BoxFit.cover,
              ).cornerRadiusWithClipRRect(defaultRadius - 3),
            ),
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
                  splashColor: Colors.black.withOpacity(0.3),
                  onTap: () {
                    AuthorDetailsScreen(authorData: widget.authorData).launch(context);
                  },
                ),
              ),
            ),
          ],
        ),
        isWeb
            ? SizedBox(
                width: 76,
                child: Marquee(
                  child: Text(
                    widget.authorData!.name.validate().capitalizeFirstLetter(),
                    style: boldTextStyle(),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ).paddingTop(8)
            : SizedBox(),
      ],
    );
  }
}

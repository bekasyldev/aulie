import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/cache_image_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/book_ratting_list_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/book/component/write_review_component.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class RattingListComponent extends StatefulWidget {
  static String tag = '/RattingListComponent';

  final BookRatingData? bookRatingData;
  final bookId;

  RattingListComponent({this.bookRatingData, this.bookId});

  @override
  RattingListComponentState createState() => RattingListComponentState();
}

class RattingListComponentState extends State<RattingListComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> deleteReviewApi(BuildContext context) async {
    Map request = {"id": widget.bookRatingData!.ratingId.validate()};
    appStore.setLoading(true);

    await deleteReview(request).then((res) async {
      appStore.setLoading(false);
      if (res.status!) {
        toast(res.message.toString());
        LiveStream().emit(IS_REVIEW_CHANGE);
      } else {
        toast(res.message);
      }
    }).catchError((e) {
      toast(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Container(
          decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor, border: Border.all(color: defaultPrimaryColor.withOpacity(.2))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.bookRatingData!.userName.validate().toString(), style: primaryTextStyle()),
                    4.height,
                    Text(formatDate(widget.bookRatingData!.createdAt.validate()), style: secondaryTextStyle(size: 12)),
                  ],
                ),
                leading: Container(
                  decoration: boxDecorationDefault(boxShadow: []),
                  child: CachedImageWidget(
                    url: widget.bookRatingData!.profileImage.validate(),
                    fit: BoxFit.cover,
                    placeHolderImage: user_place_holder_img,
                    height: 40,
                  ).cornerRadiusWithClipRRect(defaultRadius),
                ),
                trailing: TextIcon(
                  edgeInsets: EdgeInsets.all(0),
                  maxLine: 1,
                  spacing: 4,
                  prefix: Icon(Icons.star, color: Colors.amberAccent, size: 16),
                  text: widget.bookRatingData!.rating?.toStringAsFixed(1).validate(),
                ),
              ).paddingOnly(top: 8).onTap(
                () {
                  //
                },
              ),
              ReadMoreText(
                widget.bookRatingData!.review.validate(),
                style: secondaryTextStyle(),
              ).paddingOnly(left: 16, right: 16, bottom: appStore.userId == widget.bookRatingData!.userId ? 0 : 16),
              Align(
                alignment: Alignment.topRight,
                child: TextIcon(
                  prefix: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Text(language!.edit, style: primaryTextStyle()),
                    decoration: boxDecorationWithRoundedCorners(border: Border.all(color: defaultPrimaryColor), backgroundColor: transparentColor),
                  ).onTap(
                    () async {
                      showInDialog(
                        context,
                        shape: RoundedRectangleBorder(borderRadius: radius()),
                        contentPadding: EdgeInsets.all(0),
                        builder: (BuildContext context) {
                          return WriteReviewComponent(
                            bookRatingData: widget.bookRatingData,
                            bookId: widget.bookId,
                            message: widget.bookRatingData!.review,
                            ratting: widget.bookRatingData!.rating,
                            isUpdate: true,
                          );
                        },
                      );
                    },
                  ),
                  suffix: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Text(language!.delete, style: primaryTextStyle()),
                    decoration: boxDecorationWithRoundedCorners(border: Border.all(color: redColor.withOpacity(.5)), backgroundColor: transparentColor),
                  ).onTap(
                    () async {
                      showConfirmDialogCustom(
                        context,
                        title: language!.areYouSureWantToRemoveReview,
                        dialogType: DialogType.DELETE,
                        onAccept: (BuildContext context) async {
                          await deleteReviewApi(context);
                        },
                      );
                    },
                  ),
                ),
              ).paddingOnly(bottom: 10, right: 4).visible(appStore.userId == widget.bookRatingData!.userId),
            ],
          ),
        );
      },
    );
  }
}

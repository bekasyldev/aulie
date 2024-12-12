// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/book_ratting_list_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class WriteReviewComponent extends StatefulWidget {
  static String tag = '/WriteReviewComponent';
  final int? bookId;
  late num? ratting;
  final message;
  final bool? isUpdate;
  final BookRatingData? bookRatingData;

  WriteReviewComponent({this.bookId, this.message, this.ratting, this.isUpdate, this.bookRatingData});

  @override
  WriteReviewComponentState createState() => WriteReviewComponentState();
}

class WriteReviewComponentState extends State<WriteReviewComponent> {
  TextEditingController messageController = TextEditingController();
  FocusNode messageFocusNode = FocusNode();

  num? rating = 0.0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    messageController.text = widget.isUpdate == true ? widget.bookRatingData!.review.validate() : '';
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> addReviewApi(BuildContext context) async {
    Map request = {
      "book_id": widget.bookId,
      "user_id": appStore.userId,
      "rating": rating,
      "review": messageController.text.trim(),
    };
    appStore.setLoading(true);

    await addReview(request).then((res) async {
      if (res.status!) {
        toast(res.message.toString());
        LiveStream().emit(IS_REVIEW_CHANGE);
        setState(() {});
      } else {
        toast(res.message);
      }
    }).catchError((e) {
      toast(e.toString());
    });
    appStore.setLoading(false);
  }

  Future<void> updateReviewApi(BuildContext context) async {
    Map request = {
      "book_id": widget.bookId,
      "user_id": appStore.userId,
      "rating_id": widget.bookRatingData!.ratingId,
      "rating": widget.ratting.validate(),
      "review": messageController.text.validate(),
    };
    appStore.setLoading(true);

    await updateReview(request).then((res) async {
      if (res.status!) {
        toast(res.message.toString());
        LiveStream().emit(IS_REVIEW_CHANGE);
        setState(() {});
      } else {
        toast(res.message);

        finish(context);
      }
    }).catchError((e) {
      toast(e.toString());
    });
    appStore.setLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      width: isWeb ? context.width() * 0.35 : context.width(),
      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              16.height,
              Text(language!.yourReview, style: boldTextStyle(size: 18)).center(),
              16.height,
              RatingBarWidget(
                itemCount: 5,
                size: 36,
                activeColor: Colors.amber,
                rating: widget.isUpdate.validate() ? widget.ratting.validate().toDouble() : rating.validate().toDouble(),
                onRatingChanged: (value) {
                  rating = value;
                  widget.isUpdate.validate() ? widget.ratting = value : rating = value;
                  setState(() {});
                },
              ).center(),
              16.height,
              AppTextField(
                controller: messageController,
                focus: messageFocusNode,
                autoFocus: true,
                textFieldType: TextFieldType.MULTILINE,
                decoration: inputDecoration(context, hintText: language!.message),
                onFieldSubmitted: (value) {
                  hideKeyboard(context);
                  finish(context);
                  !widget.isUpdate.validate() ? addReviewApi(context) : updateReviewApi(context);
                },
              ),
              16.height,
              AppButton(
                color: defaultPrimaryColor,
                text: language!.submit,
                onTap: () {
                  hideKeyboard(context);
                  finish(context);
                  !widget.isUpdate.validate() ? addReviewApi(context) : updateReviewApi(context);
                },
              ).center()
            ],
          ),
        ],
      ),
    );
  }
}

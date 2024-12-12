import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/book_ratting_list_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/book/component/review_text_component.dart';
import 'package:granth_flutter/utils/colors.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class RattingReviewComponent extends StatefulWidget {
  final num? totalRatting;
  final int? bookId;

  RattingReviewComponent({this.totalRatting, this.bookId});

  @override
  _RattingReviewComponentState createState() => _RattingReviewComponentState();
}

class _RattingReviewComponentState extends State<RattingReviewComponent> {
  List<BookRatingData> ratingList = [];

  double oneStarTotal = 0;
  double twoStarTotal = 0;
  double threeStarTotal = 0;
  double fourStarTotal = 0;
  double fiveStarTotal = 0;

  @override
  void initState() {
    super.initState();
    init();

    LiveStream().on(IS_REVIEW_CHANGE, (p0) {
      init();
    });
  }

  void init() async {
    Map request = {CommonKeys.bookId: widget.bookId, "user_id": appStore.userId};
    appStore.setLoading(true);

    getAllBookReview(request).then((res) async {
      appStore.setLoading(false);
      ratingList.clear();
      oneStarTotal = 0;
      twoStarTotal = 0;
      threeStarTotal = 0;
      fourStarTotal = 0;
      fiveStarTotal = 0;
      ratingList.addAll(res.data!);

      ratingList.forEach((element) {
        switch (element.rating!.toStringAsFixed(0).toInt()) {
          case 1:
            oneStarTotal++;
            break;
          case 2:
            twoStarTotal++;
            break;
          case 3:
            threeStarTotal++;
            break;
          case 4:
            fourStarTotal++;
            break;
          case 5:
            fiveStarTotal++;
        }
      });

      oneStarTotal = (oneStarTotal * 100) / ratingList.length;
      twoStarTotal = (twoStarTotal * 100) / ratingList.length;
      threeStarTotal = (threeStarTotal * 100) / ratingList.length;
      fourStarTotal = (fourStarTotal * 100) / ratingList.length;
      fiveStarTotal = (fiveStarTotal * 100) / ratingList.length;
      setState(() {});
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    LiveStream().dispose(IS_REVIEW_CHANGE);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          TextIcon(
            text: widget.totalRatting!.toStringAsFixed(1).toDouble().toString().validate(),
            textStyle: boldTextStyle(size: 20),
            spacing: 4,
            suffix: Icon(Icons.star, color: Colors.amber, size: 22),
          ),
          10.width,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ReviewTextComponent(label: '1', totalValue: oneStarTotal, color: poor, txtSize: 14, iconSize: 18, width: 400),
              4.height,
              ReviewTextComponent(label: '2', totalValue: twoStarTotal, color: belowAverage, txtSize: 14, iconSize: 18, width: 400),
              4.height,
              ReviewTextComponent(label: '3', totalValue: threeStarTotal, color: average, txtSize: 14, iconSize: 18, width: 400),
              4.height,
              ReviewTextComponent(label: '4', totalValue: fourStarTotal, color: good, txtSize: 14, iconSize: 18, width: 400),
              4.height,
              ReviewTextComponent(label: '5', totalValue: fiveStarTotal, color: excellent, txtSize: 14, iconSize: 18, width: 400),
            ],
          ).expand(),
        ],
      ),
    );
  }
}

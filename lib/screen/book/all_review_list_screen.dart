import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/book_ratting_list_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/book/component/mobile_all_review_list_res_component.dart';
import 'package:granth_flutter/screen/book/web_screen/all_review_list_screen_web.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class AllReviewListScreen extends StatefulWidget {
  static String tag = '/AllReviewListScreen';
  final List<BookRatingData> bookRatingData;
  final num? totalRatting;
  final int? bookId;
  final String? webBookName;

  AllReviewListScreen({required this.bookRatingData, this.totalRatting, this.bookId, this.webBookName});

  @override
  AllReviewListScreenState createState() => AllReviewListScreenState();
}

class AllReviewListScreenState extends State<AllReviewListScreen> {
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
    return Observer(
      builder: (context) {
        return Responsive(
          mobile: MobileAllReviewListComponent(
            totalRatting: widget.totalRatting,
            bookId: widget.bookId,
            ratingList: ratingList,
            oneStarTotal: oneStarTotal,
            twoStarTotal: twoStarTotal,
            threeStarTotal: threeStarTotal,
            fourStarTotal: fourStarTotal,
            fiveStarTotal: fiveStarTotal,
          ),
          web: WebAllReviewListScreen(
            totalRatting: widget.totalRatting,
            bookId: widget.bookId,
            ratingList: ratingList,
            oneStarTotal: oneStarTotal,
            twoStarTotal: twoStarTotal,
            threeStarTotal: threeStarTotal,
            fourStarTotal: fourStarTotal,
            fiveStarTotal: fiveStarTotal,
            bookName: widget.webBookName,
          ),
          tablet: MobileAllReviewListComponent(
            totalRatting: widget.totalRatting,
            bookId: widget.bookId,
            ratingList: ratingList,
            oneStarTotal: oneStarTotal,
            twoStarTotal: twoStarTotal,
            threeStarTotal: threeStarTotal,
            fourStarTotal: fourStarTotal,
            fiveStarTotal: fiveStarTotal,
          ),
        );
      },
    );
  }
}

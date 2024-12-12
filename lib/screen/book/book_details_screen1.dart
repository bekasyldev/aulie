import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/component/no_data_found_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/models/all_book_details_model.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/book/component/mobile_book_details_res1_component.dart';
import 'package:granth_flutter/screen/book/web_screen/book_details_screen1_web.dart';
import 'package:granth_flutter/utils/admob_utils.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class BookDetailsScreen1 extends StatefulWidget {
  static String tag = '/BookDetailsScreen1';
  final int? bookId;
  final BookDetailResponse? bookDetailResponse;

  BookDetailsScreen1({this.bookId, this.bookDetailResponse});

  @override
  BookDetailsScreen1State createState() => BookDetailsScreen1State();
}

class BookDetailsScreen1State extends State<BookDetailsScreen1> {
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
    init();

    if (isMobile) {
      _bannerAd = createBannerAd()..load();
      if (mAdShowCount < 5) {
        mAdShowCount++;
      } else {
        mAdShowCount = 0;
        if (ENABLE_ADMOB) {
          createInterstitialAd().catchError((e) {});
        }
      }
    }
  }

  Future<void> init() async {
    afterBuildCreated(() async {
      await setStatusBarColor(transparentColor, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark);
      LiveStream().on(CART_DATA_CHANGED, (p0) async {
        setState(() {});
      });
      LiveStream().on(IS_REVIEW_CHANGE, (p0) async {
        setState(() {});
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    LiveStream().dispose(CART_DATA_CHANGED);
    LiveStream().dispose(IS_REVIEW_CHANGE);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: FutureBuilder<AllBookDetailsModel>(
              future: getBookDetails(
                {
                  "book_id": widget.bookId.validate(),
                  "user_id": appStore.userId.validate(),
                },
              ),
              builder: (context, snap) {
                if (snap.hasData) {
                  if (snap.data == null) NoDataFoundWidget();
                  return Responsive(
                    mobile: MobileBookDetailsRes1Component(bookData: snap.data!, bookId: widget.bookId),
                    web: WebBookDetails1Screen(bookData: snap.data!, bookId: widget.bookId),
                    tablet: MobileBookDetailsRes1Component(bookData: snap.data!, bookId: widget.bookId),
                  );
                }
                return snapWidgetHelper(snap, loadingWidget: AppLoaderWidget().center());
              },
            ),
          ),
        );
      },
    );
  }
}

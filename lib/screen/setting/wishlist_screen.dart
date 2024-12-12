import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/setting/component/mobile_wish_list_component.dart';
import 'package:granth_flutter/screen/setting/web_screen/wishlist_screen_web.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class WishListScreen extends StatefulWidget {
  static String tag = '/WishListScreen';

  @override
  WishListScreenState createState() => WishListScreenState();
}

class WishListScreenState extends State<WishListScreen> {
  double size = 0;
  double partition = 0;
  double minus = 0;

  List<BookDetailResponse>? wishList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    appStore.setLoading(true);
    afterBuildCreated(() async {
      getWishList().then((value) {
        appStore.setLoading(false);
        wishList = value.data.validate();
        setState(() {});
      });
    });
    LiveStream().on(WISH_LIST_ITEM_CHANGED, (p0) async {
      appStore.setLoading(true);
      getWishList().then((value) {
        appStore.setLoading(false);
        wishList = value.data.validate();
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
    LiveStream().dispose(WISH_LIST_ITEM_CHANGED);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = context.width();
    partition = 0;
    if (size < 1200) {
      partition = 3;
      minus = 137;
    } else {
      partition = 4;
      minus = 100;
    }
    return Scaffold(
      body: Responsive(
        mobile: MobileWishListComponent(wishList: wishList),
        web: WebWishListScreen(wishList: wishList, width: (context.width() / partition) - minus),
        tablet: MobileWishListComponent(wishList: wishList, width: (context.width() / 3) - 22),
      ),
    );
  }
}

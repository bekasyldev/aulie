import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/component/no_data_found_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/all_book_details_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/book/component/mobile_details_res2_component.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class BookDetailsScreen2 extends StatefulWidget {
  static String tag = '/BookDetailScreen';
  final int? bookId;

  BookDetailsScreen2({this.bookId});

  @override
  _BookDetailsScreen2State createState() => _BookDetailsScreen2State();
}

class _BookDetailsScreen2State extends State<BookDetailsScreen2> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    tabController = TabController(length: 3, vsync: this);
    afterBuildCreated(() {
      appStore.setLoading(false);
      LiveStream().on(IS_REVIEW_CHANGE, (p0) async {
        setState(() {});
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Scaffold(
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
                    mobile: MobileDetailsRes2Component(bookData2: snap.data, bookId: widget.bookId, snapData: snap),
                    tablet: MobileDetailsRes2Component(bookData2: snap.data, bookId: widget.bookId, snapData: snap),
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

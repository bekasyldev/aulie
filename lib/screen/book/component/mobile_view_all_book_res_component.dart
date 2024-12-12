import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/book/component/view_all_book_component.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileViewAllBookResComponent extends StatefulWidget {
  final String? type;
  final String? title;
  final double? width;

  MobileViewAllBookResComponent({this.type, this.title, this.width});

  @override
  _MobileViewAllBookResComponentState createState() => _MobileViewAllBookResComponentState();
}

class _MobileViewAllBookResComponentState extends State<MobileViewAllBookResComponent> {
  List<BookDetailResponse> bookList = [];

  int page = 1;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    fetchAllBookListApi();
  }

  /// Fetch All Book List Api
  Future fetchAllBookListApi() async {
    appStore.setLoading(true);

    await getAllBooks(type: widget.type.validate(), page: page).then((res) {
      if (page == 1) bookList.clear();

      bookList.addAll(res.data.validate());
      isLastPage = PER_PAGE_ITEM != res.data!.length;
    }).catchError((e) {
      toast(e.toString());
    });

    setState(() {});
    appStore.setLoading(false);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(widget.title.validate(), elevation: 0),
      body: Stack(
        children: [
          if (bookList.validate().isNotEmpty)
            AnimatedScrollView(
              padding: EdgeInsets.all(defaultRadius),
              listAnimationType: ListAnimationType.FadeIn,
              dragStartBehavior: DragStartBehavior.start,
              onNextPage: () {
                if (!isLastPage) {
                  page++;
                  fetchAllBookListApi();
                }
              },
              children: [
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(
                    bookList.validate().length,
                    (index) {
                      BookDetailResponse? mData = bookList.validate()[index];
                      return ViewAllBookComponent(
                        bookDetailResponse: mData,
                        width: widget.width,
                        isViewAllBooks: true,
                        discountTag: isWeb ? 40 : null,
                      );
                    },
                  ),
                ),
              ],
            ),
          Observer(
            builder: (context) {
              return NoDataWidget(
                title: language!.noDataFound,
                image: no_data_view,
              ).visible(bookList.validate().isEmpty && !appStore.isLoading).center();
            },
          ),
          Observer(
            builder: (context) {
              return AppLoaderWidget().visible(appStore.isLoading).center();
            },
          ),
        ],
      ),
    );
  }
}

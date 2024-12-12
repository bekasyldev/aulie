import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/book/component/view_all_book_component.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class WebViewAllBookScreen extends StatefulWidget {
  final String? type;
  final double? width;
  final String? title;

  WebViewAllBookScreen({this.type, this.width, this.title});

  @override
  _WebViewAllBookScreenState createState() => _WebViewAllBookScreenState();
}

class _WebViewAllBookScreenState extends State<WebViewAllBookScreen> {
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
      appBar: appBarWidget('', elevation: 0, color: context.dividerColor.withOpacity(0.1)),
      body: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.start,
        child: Column(
          children: [
            WebBreadCrumbWidget(context, title: widget.title, subTitle1: language!.dashboard, subTitle2: widget.title),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.width() * 0.8, minWidth: context.width() * 0.8),
              child: Stack(
                children: [
                  if (bookList.validate().isNotEmpty)
                    AnimatedScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      onNextPage: () {
                        if (!isLastPage) {
                          page++;
                          fetchAllBookListApi();
                        }
                      },
                      children: [
                        Wrap(
                          spacing: 22,
                          runSpacing: 22,
                          children: List.generate(
                            bookList.validate().length,
                            (index) {
                              BookDetailResponse? mData = bookList.validate()[index];
                              return Container(
                                padding: EdgeInsets.all(defaultRadius),
                                width: widget.width,
                                decoration: boxDecorationDefault(boxShadow: [BoxShadow(color: Colors.transparent)], color: defaultPrimaryColor.withOpacity(0.1)),
                                child: ViewAllBookComponent(bookDetailResponse: mData, isViewAllBooks: true, discountTag: 70),
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
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/component/no_data_found_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/book/component/book_component.dart';
import 'package:granth_flutter/screen/dashboard/component/recent_search_component.dart';
import 'package:granth_flutter/screen/dashboard/component/search_history_component.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class WebSearchScreen extends StatefulWidget {
  final double? width;

  WebSearchScreen({this.width});

  @override
  _WebSearchScreenState createState() => _WebSearchScreenState();
}

class _WebSearchScreenState extends State<WebSearchScreen> {
  TextEditingController searchBookController = TextEditingController();
  ScrollController scrollController = ScrollController();

  List<BookDetailResponse> mBookList = [];
  List searchHistory = <String>[];

  String mSearchText = '';

  bool isNoSearchResultFound = false;
  bool isLastPage = false;

  int page = 1;
  int? totalPages = 1;

  @override
  void initState() {
    super.initState();
    getSearchHistory();
    scrollController.addListener(() {
      scrollHandler();
    });
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  getSearchHistory() async {
    searchHistory = await getSearchValue();
    setState(() {});
  }

  ///get view all bookData
  Future getViewAllBookData(searchText, {bool isNewSearch = false}) async {
    if (isNewSearch && searchBookController.text.isNotEmpty) {
      mBookList.clear();
    }
    this.mSearchText = searchText;
    appStore.setLoading(true);

    await bookListApi(page: page, searchText: searchText).then((response) {
      if (response.data!.length > 0) {
        isNoSearchResultFound = false;
        mBookList.addAll(response.data!);
        totalPages = response.pagination!.totalPages;
      }
      setState(() {
        if (mBookList.length == 0 && response.data!.length < 1) {
          isNoSearchResultFound = true;
        }
        appStore.setLoading(false);
      });
    }).catchError((onError) {
      appStore.setLoading(false);
      log(onError.toString());
    });
  }

  scrollHandler() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLastPage) {
      page++;
      if (totalPages! >= page) {
        getViewAllBookData(mSearchText);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        '',
        color: context.dividerColor.withOpacity(0.1),
        elevation: 0,
        flexibleSpace: Padding(
          padding: EdgeInsets.symmetric(horizontal: 55, vertical: 12),
          child: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: context.width() * 0.2),
                child: Row(
                  children: [
                    Image.asset(transparent_app_logo, height: 40, width: 40, fit: BoxFit.cover),
                    Text('Granth', style: boldTextStyle(size: 20)),
                  ],
                ),
              ),
              120.width,
              Container(
                constraints: BoxConstraints(maxWidth: context.width() * 0.4),
                child: AppTextField(
                  controller: searchBookController,
                  textFieldType: TextFieldType.NAME,
                  decoration: inputDecoration(context, labelText: false, hintText: language!.searchBooks, preFixIcon: Icon(Icons.search, color: context.iconColor)),
                  onFieldSubmitted: (value) {
                    hideKeyboard(context);
                    if (searchBookController.text.isNotEmpty) addToSearchArray(searchBookController.text);
                    getSearchHistory();
                    if (searchBookController.text.isNotEmpty) getViewAllBookData(searchBookController.text, isNewSearch: true);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WebBreadCrumbWidget(context, title: language!.searchBooks.capitalizeFirstLetter(), subTitle1: language!.dashboard, subTitle2: language!.searchBooks),
            Stack(
              children: [
                AnimatedScrollView(
                  primary: false,
                  padding: EdgeInsets.only(left: 50, right: 50),
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RecentSearchComponent(
                          isWebSearch: true,
                          onRecentSearch: () {
                            clearSearchHistory();

                            getSearchHistory();
                            mBookList.clear();
                            searchBookController.text = '';
                            mSearchText = '';
                          },
                        ).visible(searchHistory.length > 0),
                        SearchHistoryComponent(
                          searchHistory,
                          onSearchHistory: (item) async {
                            await getViewAllBookData(item, isNewSearch: true);
                          },
                        ).visible(searchHistory.length > 0),
                        Padding(
                          padding: EdgeInsets.only(top: defaultRadius),
                          child: Text(
                            language!.searchResultFor + " \"" + mSearchText + "\"",
                            style: secondaryTextStyle(size: 20),
                          ).visible(mSearchText.length > 0),
                        ).visible(!appStore.isLoading),
                        16.height,
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 22,
                            children: List.generate(mBookList.length, (index) {
                              return SizedBox(
                                width: widget.width ?? (context.width() / 2) - 20,
                                child: BookComponent(bookData: mBookList[index], isCenterBookInfo: true, isLeftDisTag: 50),
                              );
                            }),
                          ).visible(mBookList.isNotEmpty),
                        ),
                      ],
                    ),
                  ],
                ),
                Center(child: Observer(builder: (context) => AppLoaderWidget().visible(appStore.isLoading))),
                NoDataWidget(
                  title: language!.searchForBooksBy,
                ).withHeight(context.height() * 0.5).center().visible(searchHistory.isEmpty),
                Observer(builder: (context) => NoDataFoundWidget().visible(searchHistory.isNotEmpty && !appStore.isLoading && mBookList.isEmpty))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

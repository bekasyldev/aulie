import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/component/no_data_found_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/book/component/book_component.dart';
import 'package:granth_flutter/screen/book/component/voice_search_component.dart';
import 'package:granth_flutter/screen/dashboard/component/recent_search_component.dart';
import 'package:granth_flutter/screen/dashboard/component/search_history_component.dart';
import 'package:granth_flutter/screen/dashboard/web_screen/search_screen_web.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchBookController = TextEditingController();
  ScrollController scrollController = ScrollController();
  SpeechToText speech = SpeechToText();

  List<BookDetailResponse> mBookList = [];
  List searchHistory = <String>[];

  String lastError = "";
  String lastStatus = "";
  String mSearchText = "";

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
    initSpeechState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> initSpeechState() async {
    await speech.initialize(onError: errorListener, onStatus: statusListener);
  }

  void startListening() {
    mSearchText = "";
    lastError = "";
    speech.listen(onResult: resultListener);

    setState(() {});
  }

  void stopListening() {
    speech.stop();
    setState(() {});
  }

  void cancelListening() {
    speech.cancel();
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      mSearchText = "${result.recognizedWords}";
      addToSearchArray(mSearchText);
      getSearchHistory();

      if (searchHistory.isNotEmpty) {
        getViewAllBookData(mSearchText, isNewSearch: true);
      }
    });
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = "${error.errorMsg} - ${error.permanent}";
    });
  }

  void statusListener(String status) {
    setState(() {
      lastStatus = "$status";
    });
  }

  getSearchHistory() async {
    searchHistory = await getSearchValue();
    setState(() {});
  }

  scrollHandler() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLastPage) {
      page++;
      if (totalPages! >= page) {
        getViewAllBookData(mSearchText);
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: context.scaffoldBackgroundColor,
      appBar: isWeb ? null : appBarWidget('', elevation: 0),
      bottomSheet: VoiceSearchComponent(searchText: mSearchText).visible(speech.isListening),
      body: Responsive(
        web: WebSearchScreen(width: context.width() / 6 - 28),
        mobile: Stack(
          children: [
            AnimatedScrollView(
              primary: false,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      8.height,
                      AppTextField(
                        controller: searchBookController,
                        textFieldType: TextFieldType.NAME,
                        onFieldSubmitted: (value) {
                          hideKeyboard(context);
                          if (searchBookController.text.isNotEmpty) addToSearchArray(searchBookController.text);
                          getSearchHistory();
                          if (searchBookController.text.isNotEmpty) getViewAllBookData(searchBookController.text, isNewSearch: true);
                        },
                        decoration: inputDecoration(
                          context,
                          labelText: false,
                          hintText: language!.searchBooks,
                          preFixIcon: Icon(Icons.search, color: context.iconColor),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.mic, color: appStore.isDarkMode ? Colors.white : black),
                            onPressed: () {
                              startListening();
                            },
                          ),
                        ),
                      ),
                      16.height,
                      RecentSearchComponent(
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
                      Wrap(
                        runSpacing: 8,
                        spacing: 16,
                        children: List.generate(mBookList.length, (index) {
                          return Container(
                            child: BookComponent(bookWidth: (context.width() / 2) - 22, bookData: mBookList[index]),
                          );
                        }),
                      ).visible(mBookList.isNotEmpty),
                    ],
                  ),
                ),
              ],
            ),
            Center(child: Observer(builder: (context) => AppLoaderWidget().visible(appStore.isLoading))),
            NoDataWidget(
              title: language!.searchForBooksBy,
            ).withHeight(context.height()).center().visible(searchHistory.isEmpty).paddingAll(16),
            Observer(builder: (context) => NoDataFoundWidget().visible(searchHistory.isNotEmpty && !appStore.isLoading && mBookList.isEmpty))
          ],
        ),
      ),
    );
  }
}

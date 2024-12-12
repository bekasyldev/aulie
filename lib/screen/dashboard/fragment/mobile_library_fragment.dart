import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/book_list_model.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/models/downloaded_book.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/book/component/library_componet.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/file_common.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileLibraryFragment extends StatefulWidget {
  @override
  _MobileLibraryFragmentState createState() => _MobileLibraryFragmentState();
}

class _MobileLibraryFragmentState extends State<MobileLibraryFragment> {
  List<DownloadedBook> downloadedList = [];
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    LiveStream().on(REFRESH_lIBRARY_LIST, (p0) async {
      if (mounted) {
        await fetchData();
      }
    });
    init();
  }

  void init() async {
    fetchData();
  }

  Future<void> fetchData() async {
    appStore.setLoading(true);
    List<DownloadedBook>? books = await dbHelper.queryAllRows();

    if (books.isNotEmpty) {
      List<DownloadedBook>? downloadable = [];
      books.forEach((DownloadedBook? book) {
        if (book!.fileType == PURCHASED_BOOK) {
          downloadable.add(book);
        }
      });
      setState(() {
        downloadedList.clear();
        downloadedList.addAll(downloadable);

        downloadedList.forEach((purchaseItem) async {
          String filePath = await getBookFilePathFromName(purchaseItem.bookName.validate(), isSampleFile: false);
          if (!File(filePath).existsSync()) {
            purchaseItem.isDownloaded = false;
          } else {
            purchaseItem.isDownloaded = true;
          }
        });
      });
    } else {
      downloadedList.clear();
    }
    
    isDataLoaded = true;
    setState(() {});
    appStore.setLoading(false);
  }

  Future<void> removeBook(DownloadedBook task, context) async {
    String filePath = await getBookFilePathFromName(task.bookName.toString(), isSampleFile: false);
    if (!File(filePath).existsSync()) {
      toast("Path: File you're trying to remove doesn't Exist");
    } else {
      await dbHelper.delete(task.bookId.validate().toInt()).then((value) => toast('Removed from Downloads'));
      await File(filePath).delete();

      init();
      setState(() {});
      LiveStream().emit(REFRESH_lIBRARY_LIST);
    }
  }

  @override
  void dispose() {
    LiveStream().dispose(REFRESH_lIBRARY_LIST);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                expandedHeight: 120,
                pinned: true,
                titleSpacing: 16,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(language!.myLibrary, style: boldTextStyle()),
                  titlePadding: EdgeInsets.only(bottom: 16, left: 16),
                ),
              )
            ];
          },
          body: Stack(
            children: [
              downloadedList.isNotEmpty
                  ? LibraryComponent(
                      list: downloadedList,
                      i: 0,
                      isSampleExits: false,
                      onRemoveBookUpdate: (DownloadedBook bookDetail) {
                        removeBook(bookDetail, context);
                        setState(() {});
                      },
                      onDownloadUpdate: () {
                        fetchData();
                        setState(() {});
                      },
                    )
                  : NoDataWidget(
                      title: language!.noPurchasedBookAvailable,
                    ).visible(isDataLoaded && !appStore.isLoading),
            ],
          ),
        ),
      ),
    );
  }
}
  
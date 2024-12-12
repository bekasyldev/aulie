import 'dart:io';

import 'package:flutter/material.dart';
import 'package:granth_flutter/component/ink_well_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/downloaded_book.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/file_common.dart';
import 'package:nb_utils/nb_utils.dart';

class DownloadedBookListComponent extends StatefulWidget {
  @override
  _DownloadedBookListComponentState createState() => _DownloadedBookListComponentState();
}

class _DownloadedBookListComponentState extends State<DownloadedBookListComponent> {
  Future<List<DownloadedBook>>? future;
  List<DownloadedBook>? downloadedBookList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = dbHelper.queryAllRows();
  }

  Future<void> removeBook(DownloadedBook task, context, isSample) async {
    String filePath = await getBookFilePathFromName(task.bookName.toString(), isSampleFile: isSample);
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
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(16),
        child: FutureBuilder<List<DownloadedBook>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) if (snapshot.data!.isNotEmpty)
              return SingleChildScrollView(
                child: Wrap(
                  runSpacing: 16,
                  spacing: 16,
                  children: snapshot.data!.map((downloadedBook) {
                    DownloadedBook bookDetail = snapshot.data![snapshot.data!.indexOf(downloadedBook)];
                    return SizedBox(
                      width: (context.width() - 70) / 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              SizedBox(
                                child: InkWellWidget(
                                  image: bookDetail.frontCover.validate(),
                                  onTap: () {
                                    handleViewClick(
                                      context,
                                      bookId: bookDetail.bookId.toInt(),
                                      filePath: bookDetail.filePath.validate(),
                                      bookName: bookDetail.bookName.validate(),
                                    );
                                  },
                                ).cornerRadiusWithClipRRect(defaultRadius),
                              ),
                              Positioned(
                                bottom: 16,
                                right: 0,
                                child: InkWell(
                                  onTap: () {
                                    showConfirmDialogCustom(
                                      context,
                                      title: language!.areYouSureWantToDelete,
                                      dialogType: DialogType.DELETE,
                                      onAccept: (dynamic) {
                                        removeBook(downloadedBook, context, false);
                                      },
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(4.0),
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: whiteColor),
                                    padding: EdgeInsets.all(4.0),
                                    child: Icon(Icons.delete, size: 24, color: Colors.red),
                                  ),
                                ),
                              )
                            ],
                          ),
                          16.height,
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            return NoDataWidget(title: 'No Download available');
          },
        ));
  }
}

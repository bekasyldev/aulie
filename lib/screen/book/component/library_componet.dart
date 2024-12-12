import 'dart:io';

import 'package:flutter/material.dart';
import 'package:granth_flutter/component/ink_well_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/downloaded_book.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/file_common.dart';
import 'package:granth_flutter/utils/permissions.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class LibraryComponent extends StatefulWidget {
  static String tag = '/LibraryComponent';

  final List<DownloadedBook>? list;
  final int? i;
  final bool? isSampleExits;

  final Function? onDownloadUpdate;
  final Function? onRemoveBookUpdate;

  LibraryComponent({this.list, this.i, this.isSampleExits = false, this.onDownloadUpdate, this.onRemoveBookUpdate});

  @override
  LibraryComponentState createState() => LibraryComponentState();
}

class LibraryComponentState extends State<LibraryComponent> {
  String finalFilePath = '';
  String fileName = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: widget.list.validate().map((e) {
                DownloadedBook bookDetail = widget.list![widget.list!.indexOf(e)];

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
                                if (widget.i != 1) {
                                  handleViewClick(
                                    context,
                                    bookId: bookDetail.bookId.toInt(),
                                    filePath: bookDetail.filePath.validate(),
                                    bookName: bookDetail.bookName.validate(),
                                  );
                                } else if (widget.i == 1 && bookDetail.isDownloaded) {
                                  handleViewClick(
                                    context,
                                    bookId: bookDetail.bookId.toInt(),
                                    filePath: bookDetail.filePath.validate(),
                                    bookName: bookDetail.bookName.validate(),
                                  );
                                }
                              },
                            ).cornerRadiusWithClipRRect(defaultRadius),
                          ),
                          widget.i == 1
                              ? (!bookDetail.isDownloaded
                                  ? Positioned(
                                      bottom: 16,
                                      right: 0,
                                      child: Container(
                                        margin: EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: whiteColor),
                                        padding: EdgeInsets.all(4.0),
                                        child: Icon(Icons.file_download_outlined, size: 24, color: Colors.black),
                                      ).onTap(() async {
                                        if (await checkAndroidVersionAndStoragePermission()) {
                                          fileName = await getBookFileName(bookDetail.bookId, bookDetail.webBookPath.toString(), isSample: widget.isSampleExits);
                                          finalFilePath = await getBookFilePathFromName(fileName, isSampleFile: widget.isSampleExits);
                                          if (File(finalFilePath).existsSync()) {
                                            toast('$fileName already downloaded check it in your Local Files');

                                            return;
                                          }
                                          await downloadFile(
                                            context,
                                            filePath: bookDetail.webBookPath.toString(),
                                            downloadFileName: fileName,
                                            onUpdate: (var percentage) async {
                                              appStore.setDownloadPercentageValue(percentage);
                                              if (percentage < 100) {
                                                appStore.setDownloading(true);
                                              } else {
                                                appStore.setDownloading(false);
                                              }
                                            },
                                          ).then((value) async {
                                            ///create storage directory
                                            String path = await localPath;
                                            final savedDir = Directory(path);
                                            bool hasExisted = await savedDir.exists();

                                            if (!hasExisted) {
                                              savedDir.create();
                                            }

                                            /// insert data into database
                                            if (appStore.downloadPercentageStore == 100.00)
                                              await insertIntoDb(
                                                userid: appStore.userId.toInt().validate(),
                                                bookId: bookDetail.bookId.validate(),
                                                bookImage: bookDetail.frontCover.validate(),
                                                bookName: fileName,
                                                authorName: bookDetail.authorName.validate(),
                                                bookPath: bookDetail.filePath.validate(),
                                                filePath: finalFilePath,
                                                fileType: PURCHASED_BOOK,
                                              );

                                            ///open epub viewer or pdf viewer
                                            if (appStore.downloadPercentageStore == 100.00)
                                              handleViewClick(
                                                context,
                                                bookId: bookDetail.bookId.validate().toInt(),
                                                filePath: finalFilePath,
                                                bookName: bookDetail.bookName.validate(),
                                              );
                                          });
                                          widget.onDownloadUpdate?.call();
                                        }
                                      }),
                                    )
                                  : SizedBox())
                              : Positioned(
                                  bottom: 16,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      showConfirmDialogCustom(
                                        context,
                                        title: language!.areYouSureWantToDelete,
                                        dialogType: DialogType.DELETE,
                                        onAccept: (dynamic) {
                                          widget.onRemoveBookUpdate?.call(bookDetail);
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
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:granth_flutter/main.dart';
import 'package:internet_file/internet_file.dart';
import 'package:internet_file/storage_io.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';

import '../models/downloaded_book.dart';
import 'constants.dart';

Future<String> get localPath async {
  Directory? directory;

  if (Platform.isAndroid) {
    directory = await getExternalStorageDirectory();
  } else if (Platform.isIOS) {
    directory = await getApplicationDocumentsDirectory();
  } else {
    throw "Unsupported platform";
  }
  return directory!.path;
}

Future<String> downloadFile(BuildContext context, {required String filePath, required String downloadFileName, Function(double)? onUpdate}) async {
  final storageIO = InternetFileStorageIO();
  String storagePath = await localPath;

  await InternetFile.get(
    filePath,
    storage: storageIO,
    storageAdditional: {
      'filename': downloadFileName,
      'location': storagePath,
    },
    progress: (receivedLength, contentLength) {
      onUpdate?.call((receivedLength / contentLength) * 100);
    },
  ).catchError((e) {
    toast('Ops!Download Failed! Try Again after sometimes');
    appStore.setLoading(false);
    appStore.setDownloading(false);
    finish(context);
    return e;
  });
  return filePath;
}

Future<String> getBookFilePathFromName(String bookName, {isSampleFile = false}) async {
  String path = await localPath;
  String filePath = path + "/" + bookName;
  filePath = filePath.replaceAll("null/", "");
  print("Full File Path:>> " + filePath);
  return filePath;
}

Future<String> getBookFileName(String? bookId, String url, {isSample = false}) async {
  var name = url.split("/");
  String fileNameNew = url;
  if (name.length > 0) {
    fileNameNew = name[name.length - 1];
  }
  fileNameNew = fileNameNew.replaceAll("%", "");
  var fileName = isSample ? bookId! + "_sample_" + fileNameNew : bookId! + "_purchased_" + fileNameNew;
  int userId = appStore.userId.validate(value: 0);
  print("File Name: " + userId.toString() + "_" + fileName);
  return fileName;
}

Future<bool> checkFileIsExist({String? bookId, String? bookPath, bool sampleFile = false}) async {
  String filePath = await getBookFilePathFromName(bookPath.validate(), isSampleFile: false);
  return await File(filePath).exists();
}

Future<void> insertIntoDb({
  required String bookName,
  required String filePath,
  required int userid,
  required String bookId,
  required String bookImage,
  required String bookPath,
  required String fileType,
  required String authorName,
}) async {
  /**
   * Store data to db for offline usage
   */
  DownloadedBook _download = DownloadedBook();
  _download.bookId = bookId;
  _download.bookName = bookName;
  _download.authorName = authorName;
  _download.frontCover = bookImage;
  _download.taskId = "";
  _download.filePath = filePath;
  _download.webBookPath = bookPath;
  _download.userId = appStore.userId;
  if (fileType == SAMPLE_BOOK) {
    _download.fileType = PURCHASED_BOOK;
  } else {
    _download.fileType = PURCHASED_BOOK;
  }
  log('----------------');
  await dbHelper.insert(_download);
}

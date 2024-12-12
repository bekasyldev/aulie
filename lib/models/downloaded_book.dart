import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/utils/model_keys.dart';

class DownloadedBook {
  int? id;
  int? userId;
  String? taskId;
  String? bookId;
  String? bookName;
  String? authorName;
  String? frontCover;
  String? fileType;
  String? filePath;
  String? webBookPath;
  bool isDownloaded;

  DownloadedBook({this.userId, this.id, this.taskId, this.bookId, this.bookName, this.frontCover, this.fileType, this.filePath, this.webBookPath, this.authorName, this.isDownloaded = false});

  factory DownloadedBook.fromJson(Map<String, dynamic> json) {
    return DownloadedBook(
        id: json[LibraryBookKey.id],
        taskId: json[LibraryBookKey.taskId],
        bookId: json[CommonKeys.bookId],
        bookName: json[LibraryBookKey.bookName],
        frontCover: json[LibraryBookKey.frontCover],
        fileType: json[LibraryBookKey.fileType],
        filePath: json[LibraryBookKey.filePath],
        webBookPath: json[LibraryBookKey.webBookPath],
        authorName: json[LibraryBookKey.authorName],
        userId: json[LibraryBookKey.userId]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[LibraryBookKey.id] = this.id;
    data[LibraryBookKey.taskId] = this.taskId;
    data[CommonKeys.bookId] = this.bookId;
    data[LibraryBookKey.bookName] = this.bookName;
    data[LibraryBookKey.frontCover] = this.frontCover;
    data[LibraryBookKey.fileType] = this.fileType;
    data[LibraryBookKey.filePath] = this.filePath;
    data[LibraryBookKey.webBookPath] = this.webBookPath;
    data[LibraryBookKey.authorName] = this.authorName;
    data[LibraryBookKey.userId] = this.userId;
    return data;
  }
}

DownloadedBook defaultBook(BookDetailResponse mBookDetail, fileType) {
  return DownloadedBook(
      bookId: mBookDetail.bookId.toString(), bookName: mBookDetail.name, frontCover: mBookDetail.frontCover, fileType: fileType, filePath: mBookDetail.filePath, webBookPath: mBookDetail.filePath);
}

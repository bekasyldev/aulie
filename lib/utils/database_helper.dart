import 'dart:async';
import 'dart:io';

import 'package:granth_flutter/models/downloaded_book.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 2;
  static const String TABLE_NAME = "downloaded_book_table";
  static const String COLUMN_NAME_ID = "id";
  static const String COLUMN_NAME_USERID = "user_id";
  static const String COLUMN_NAME_TASK_ID = "task_id";
  static const String COLUMN_NAME_BOOK_ID = "book_id";
  static const String COLUMN_NAME_BOOK_NAME = "book_name";
  static const String COLUMN_AUTHOR_NAME = "author_name";
  static const String COLUMN_NAME_FRONT_COVER = "front_cover";
  static const String COLUMN_NAME_FILE_TYPE = "file_type";
  static const String COLUMN_NAME_FILE_PATH = "file_Path";
  static const String COLUMN_NAME_WEB_FILE_PATH = "web_book_path";
  static const String COLUMN_NAME_DATE_TIME = "book_date_time";
  static const String SQL_CREATE_ENTRIES = "CREATE TABLE " +
      TABLE_NAME +
      " (" +
      COLUMN_NAME_ID +
      " INTEGER PRIMARY KEY," +
      COLUMN_NAME_TASK_ID +
      " TEXT, " +
      COLUMN_NAME_USERID +
      " INTEGER, " +
      COLUMN_NAME_BOOK_ID +
      " TEXT, " +
      COLUMN_NAME_BOOK_NAME +
      " TEXT, " +
      COLUMN_AUTHOR_NAME +
      " TEXT, " +
      COLUMN_NAME_FRONT_COVER +
      " TEXT, " +
      COLUMN_NAME_FILE_TYPE +
      " TEXT, " +
      COLUMN_NAME_FILE_PATH +
      " TEXT, " +
      COLUMN_NAME_WEB_FILE_PATH +
      " TEXT, " +
      COLUMN_NAME_DATE_TIME +
      " TEXT " +
      ")";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(SQL_CREATE_ENTRIES);
  }

  Future<int> insert(DownloadedBook book) async {
    Database? db = await (instance.database);
    print(db!.path);

    return await db.insert(TABLE_NAME, book.toJson());
  }

  /*Future<List<DownloadedBook>> queryAllRows() async {
    Database? db = await (instance.database);
    var list = await db!.query(TABLE_NAME, where: '$COLUMN_NAME_USERID = "${appStore.userId}"');
    print(db.path);

    print(list.length);

    return list.map((i) => DownloadedBook.fromJson(i)).toList();
  }*/

  Future<List<DownloadedBook>> queryAllRows() async {
    Database? db = await (instance.database);
    var list = await db!.query(TABLE_NAME);
    return list.map((i) => DownloadedBook.fromJson(i)).toList();
  }

  Future<int?> queryRowCount() async {
    Database? db = await (instance.database);
    return Sqflite.firstIntValue(await db!.rawQuery('SELECT COUNT(*) FROM $TABLE_NAME'));
  }

  Future<List<DownloadedBook>> queryRowBook(bookId) async {
    Database? db = await (instance.database);
    var list = await db!.rawQuery("SELECT * FROM " + TABLE_NAME + " WHERE " + COLUMN_NAME_BOOK_ID + "='" + bookId + "'", null);

    return list.map((i) => DownloadedBook.fromJson(i)).toList();
  }

  Future<int> update(DownloadedBook book) async {
    Database? db = await (instance.database);
    int? id = book.id;
    return await db!.update(TABLE_NAME, book.toJson(), where: '$COLUMN_NAME_ID = ?', whereArgs: [id]);
  }

  Future<int> updateBookData({required int id, required String datetime}) async {
    Database? db = await (instance.database);
    print("inside db helper::#$id");

    return await db!.rawUpdate('UPDATE  $TABLE_NAME set $COLUMN_NAME_DATE_TIME= ?  WHERE book_id=?', [datetime, id]);
  }

  Future<int> delete(int? id) async {
    Database? db = await (instance.database);
    return await db!.delete(TABLE_NAME, where: '$COLUMN_NAME_BOOK_ID = ?', whereArgs: [id]);
  }

  Future<bool> isBookExist({required int bookId}) async {
    Database? db = await (instance.database);
    var queryResult = await db?.rawQuery(
      'SELECT EXISTS(SELECT 1 FROM $TABLE_NAME WHERE $COLUMN_NAME_BOOK_ID=$bookId")',
    );
    return Sqflite.firstIntValue(queryResult!) == 1;
  }
}

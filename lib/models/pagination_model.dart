import 'package:granth_flutter/utils/model_keys.dart';

class Pagination {
  int? currentPage;
  int? from;
  String? nextPage;
  var perPage;
  var previousPage;
  int? to;
  int? totalPages;
  int? totalItems;

  Pagination({this.currentPage, this.from, this.nextPage, this.perPage, this.previousPage, this.to, this.totalPages, this.totalItems});

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json[PaginationKeys.currentPage],
      from: json[PaginationKeys.from],
      nextPage: json[PaginationKeys.nextPage],
      perPage: json[PaginationKeys.perPage],
      previousPage: json[PaginationKeys.previousPage],
      to: json[PaginationKeys.to],
      totalPages: json[PaginationKeys.totalPages],
      totalItems: json[PaginationKeys.totalItems],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[PaginationKeys.currentPage] = this.currentPage;
    data[PaginationKeys.from] = this.from;
    data[PaginationKeys.nextPage] = this.nextPage;
    data[PaginationKeys.perPage] = this.perPage;
    data[PaginationKeys.previousPage] = this.previousPage;
    data[PaginationKeys.to] = this.to;
    data[PaginationKeys.totalPages] = this.totalPages;
    data[PaginationKeys.totalItems] = this.totalItems;
    return data;
  }
}

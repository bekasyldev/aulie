import 'package:flutter/material.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/screen/book/component/book_component.dart';
import 'package:nb_utils/nb_utils.dart';

class BookListComponent extends StatefulWidget {
  static String tag = '/ TopBookComponent';
  final List<BookDetailResponse>? bookDetailsList;
  final double? padding;
  final bool? isBookDetailsScreen1;

  BookListComponent({this.bookDetailsList, this.padding, this.isBookDetailsScreen1 = false});

  @override
  BookListComponentState createState() => BookListComponentState();
}

class BookListComponentState extends State<BookListComponent> {
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
    double size = context.width();
    double partition = 0;
    if (size < 1022) {
      partition = 6;
    } else if (size < 800) {
      partition = 4;
    } else {
      partition = 8;
    }
    if (widget.isBookDetailsScreen1.validate(value: false)) {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: List.generate(
          widget.bookDetailsList!.length,
          (index) {
            BookDetailResponse bookData = widget.bookDetailsList![index];
            return SizedBox(
              width: context.width() / partition - 24,
              child: BookComponent(bookData: bookData, isCenterBookInfo: true, isLeftDisTag: 20),
            );
          },
        ),
      );
    } else {
      return HorizontalList(
        itemCount: widget.bookDetailsList!.length,
        spacing: isWeb ? 40 : 16,
        runSpacing: 0,
        padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 16),
        itemBuilder: (context, index) {
          BookDetailResponse bookData = widget.bookDetailsList![index];
          return BookComponent(bookData: bookData);
        },
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:granth_flutter/component/horizontal_title_widget.dart';
import 'package:granth_flutter/screen/book/component/book_list_component.dart';
import 'package:granth_flutter/screen/book/component/book_button_component.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/all_book_details_model.dart';
import 'package:granth_flutter/screen/book/view_all_book_screen.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class OverViewComponent extends StatefulWidget {
  static String tag = '/OverViewComponent';
  final AsyncSnapshot<AllBookDetailsModel> snap;
  final bool? isBookDetail2;

  OverViewComponent(this.snap, {this.isBookDetail2 = false});

  @override
  OverViewComponentState createState() => OverViewComponentState();
}

class OverViewComponentState extends State<OverViewComponent> {
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
    return Stack(
      children: [
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: SizedBox(
              width: context.width(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.height,
                  ReadMoreText(
                    widget.snap.data!.bookDetailResponse!.first.description.validate(),
                    textAlign: TextAlign.justify,
                    style: primaryTextStyle(),
                    colorClickableText: Colors.grey,
                  ).paddingSymmetric(horizontal: 16),
                  16.height,
                  HorizontalTitleWidget(language!.authorBook, showSeeAll: false, onClick: () {
                    //
                  }),
                  16.height,
                  BookListComponent(bookDetailsList: widget.snap.data!.authorBookList, padding: 16, isBookDetailsScreen1: widget.isBookDetail2!),
                  16.height,
                  HorizontalTitleWidget(
                    language!.youMayAlsoLike,
                    onClick: () {
                      ViewAllBookScreen(type: RECOMMENDED_BOOKS, title: language!.recommendedBooks).launch(context);
                    },
                  ),
                  16.height,
                  BookListComponent(bookDetailsList: widget.snap.data!.recommendedBook, padding: 16, isBookDetailsScreen1: widget.isBookDetail2!),
                  100.height,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 16,
          right: 16,
          child: isWeb ? SizedBox() : BookButtonComponent(bookDetailResponse: widget.snap.data!.bookDetailResponse!.first),
        ),
      ],
    );
  }
}

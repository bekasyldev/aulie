import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:granth_flutter/component/app_scroll_behaviour.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/dashboard_model.dart';
import 'package:granth_flutter/screen/book/component/book_list_component.dart';
import 'package:granth_flutter/screen/book/view_all_book_screen.dart';
import 'package:granth_flutter/screen/dashboard/category_list_screen.dart';
import 'package:granth_flutter/screen/dashboard/component/author_list_component.dart';
import 'package:granth_flutter/screen/dashboard/component/category_component.dart';
import 'package:granth_flutter/screen/dashboard/component/see_all_component.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileDashboardFragment extends StatelessWidget {
  final DashboardResponse? data;

  MobileDashboardFragment({this.data});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: AppScrollBehavior(),
      child: AnimatedScrollView(
        listAnimationType: ListAnimationType.FadeIn,
        dragStartBehavior: DragStartBehavior.start,
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Author List Details
              if (data!.topAuthor!.isNotEmpty) AuthorListComponent(authorList: data!.topAuthor.validate()),

              ///Top Search Book
              if (data!.topSearchBook!.isNotEmpty) 24.height,
              SeeAllComponent(
                title: language!.topSearchBooks,
                onClick: () {
                  ViewAllBookScreen(type: TOP_SEARCH_BOOKS, title: language!.topSearchBooks).launch(context);
                },
              ).paddingSymmetric(horizontal: 16),
              16.height,
              BookListComponent(bookDetailsList: data!.topSearchBook.validate()),

              ///Popular Search Book
              if (data!.topSearchBook!.isNotEmpty) 24.height,
              SeeAllComponent(
                title: language!.popularBooks,
                onClick: () {
                  ViewAllBookScreen(type: POPULAR_BOOKS, title: language!.popularBooks).launch(context);
                },
              ).paddingSymmetric(horizontal: 16),
              16.height,
              BookListComponent(bookDetailsList: data!.popularBook.validate()),

              ///Category
              if (data!.categoryBook!.isNotEmpty) 24.height,
              SeeAllComponent(
                title: language!.categories,
                onClick: () {
                  CategoryListScreen().launch(context);
                },
              ).paddingSymmetric(horizontal: 16),
              16.height,
              CategoryComponent(categoryBookList: data!.categoryBook.validate()),

              ///Top Sell Book
              if (data!.topSellBook!.isNotEmpty) 24.height,
              SeeAllComponent(
                title: language!.topSellBooks,
                onClick: () {
                  ViewAllBookScreen(type: TOP_SELL_BOOKS, title: language!.topSellBooks).launch(context);
                },
              ).paddingSymmetric(horizontal: 16),
              16.height,
              BookListComponent(bookDetailsList: data!.topSellBook.validate()),

              ///Recommended Books
              if (data!.recommendedBook!.isNotEmpty) 24.height,
              SeeAllComponent(
                title: language!.recommendedBooks,
                onClick: () {
                  ViewAllBookScreen(type: RECOMMENDED_BOOKS, title: language!.recommendedBooks).launch(context);
                },
              ).paddingSymmetric(horizontal: 16),
              16.height,
              BookListComponent(bookDetailsList: data!.recommendedBook.validate()),
              16.height,
            ],
          ),
        ],
      ),
    );
  }
}

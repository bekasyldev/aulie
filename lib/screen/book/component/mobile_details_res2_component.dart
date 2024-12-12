import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/all_book_details_model.dart';
import 'package:granth_flutter/screen/book/component/book_details2_top_component.dart';
import 'package:granth_flutter/screen/book/component/book_information_component.dart';
import 'package:granth_flutter/screen/book/component/book_reviews_component.dart';
import 'package:granth_flutter/screen/book/component/overview_component.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileDetailsRes2Component extends StatelessWidget {
  final AllBookDetailsModel? bookData2;
  final int? bookId;
  final AsyncSnapshot<AllBookDetailsModel>? snapData;

  MobileDetailsRes2Component({this.bookData2, this.bookId, this.snapData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("", elevation: 0, color: context.scaffoldBackgroundColor),
      body: NestedScrollView(
        headerSliverBuilder: (_, innerScrolled) {
          return [
            SliverList(
              delegate: SliverChildListDelegate(
                [BookDetails2TopComponent(allBookDetailsModel: bookData2)],
              ),
            ),
          ];
        },
        body: DefaultTabController(
          length: 3,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: context.scaffoldBackgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TabBar(
                      unselectedLabelStyle: primaryTextStyle(size: 14),
                      labelColor: defaultPrimaryColor,
                      unselectedLabelColor: appStore.isDarkMode ? white : black,
                      labelStyle: boldTextStyle(size: 16),
                      isScrollable: false,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: defaultPrimaryColor,
                      tabs: [
                        Tab(child: Text(language!.overview)),
                        Tab(child: Text(language!.information)),
                        Tab(child: Text(language!.reviews)),
                      ],
                    ),
                  ),
                  TabBarView(
                    children: [
                      OverViewComponent(snapData!, isBookDetail2: false),
                      BooksInformationComponent(allBookDetailsModel: bookData2),
                      BookReviewsComponent(snapData!, bookId: bookId.validate()),
                    ],
                  ).expand(),
                ],
              ),
              Observer(
                builder: (context) {
                  return AppLoaderWidget().visible(appStore.isLoading).center();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

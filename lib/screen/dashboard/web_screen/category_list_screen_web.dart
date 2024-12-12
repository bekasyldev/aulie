import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/category_list_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/dashboard/category_wise_book_screen.dart';
import 'package:granth_flutter/screen/dashboard/component/category_list_component.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class WebCategoryListScreen extends StatefulWidget {
  WebCategoryListScreen({this.width});

  final double? width;

  @override
  State<WebCategoryListScreen> createState() => _WebCategoryListScreenState();
}

class _WebCategoryListScreenState extends State<WebCategoryListScreen> {
  List<Category> categoryList = [];

  int page = 1;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    fetchCategoryApi();
  }

  /// Fetch Category Api
  Future fetchCategoryApi() async {
    appStore.setLoading(true);

    await getAllCategoryList(page: page).then((res) {
      if (page == 1) categoryList.clear();

      categoryList.addAll(res.data.validate());
      isLastPage = PER_PAGE_ITEM != res.data!.length;
    }).catchError((e) {
      toast(e.toString());
    });

    setState(() {});
    appStore.setLoading(false);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('', elevation: 0, color: context.dividerColor.withOpacity(0.1)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WebBreadCrumbWidget(context, title: language!.categories, subTitle1: language!.dashboard, subTitle2: language!.categories),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: context.width() * 0.8, minWidth: context.width() * 0.8),
              child: Stack(
                children: [
                  if (categoryList.validate().isNotEmpty)
                    AnimatedScrollView(
                      listAnimationType: ListAnimationType.FadeIn,
                      dragStartBehavior: DragStartBehavior.start,
                      onNextPage: () {
                        if (!isLastPage) {
                          page++;
                          init();
                        }
                      },
                      children: [
                        Wrap(
                          spacing: 22,
                          runSpacing: 22,
                          children: List.generate(categoryList.length, (index) {
                            Category? mData = categoryList[index];
                            return SizedBox(
                              width: widget.width ?? context.width() / 2 - 20,
                              child: CategoryListComponent(mData: mData, isTransparentBg: true).onTap(() {
                                CategoryWiseBookScreen(categoryId: mData.categoryId).launch(context);
                              }, borderRadius: BorderRadius.circular(12)),
                            );
                          }),
                        ),
                      ],
                    ),
                  Observer(
                    builder: (context) {
                      return NoDataWidget(
                        title: language!.noDataFound,
                        image: no_data_view,
                      ).visible(categoryList.validate().isEmpty && !appStore.isLoading).center();
                    },
                  ),
                  Observer(
                    builder: (context) {
                      return AppLoaderWidget().visible(appStore.isLoading).center();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

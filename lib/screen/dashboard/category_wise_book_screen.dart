import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/models/category_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/book/component/book_component.dart';
import 'package:granth_flutter/screen/dashboard/component/category_appbar_component.dart';
import 'package:granth_flutter/screen/dashboard/web_screen/category_wise_book_screen_web.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryWiseBookScreen extends StatefulWidget {
  static String tag = '/CategoryWiseBookScreen';
  final int? categoryId;

  CategoryWiseBookScreen({this.categoryId});

  @override
  CategoryWiseBookScreenState createState() => CategoryWiseBookScreenState();
}

class CategoryWiseBookScreenState extends State<CategoryWiseBookScreen> {
  List<BookDetailResponse> bookList = [];
  List<CategoryBookResponse> subCatList = [];
  Future<List<BookDetailResponse>>? future;

  int selectedCategory = 0;
  int page = 1;

  bool isLoadingMoreData = false;
  bool isLastPage = false;

  String selectedName = ALL_BOOK;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    future = getCategoryWiseBookDetail(
      page: page,
      categoryId: widget.categoryId.validate(),
      books: bookList,
      callback: (res) {
        isLastPage = res;
      },
    );
    await subCategoryListApi();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> subCategoryListApi() async {
    var request = {"category_id": widget.categoryId};
    subCategories(request).then((result) {
      if (result.data != null && result.data!.isNotEmpty) {
        setState(() {
          subCatList.clear();
          subCatList.add(CategoryBookResponse(categoryId: widget.categoryId, subCategoryId: 0, categoryName: ALL_BOOK));
          subCatList.addAll(result.data.validate());
          selectedCategory = 0;
          selectedName = subCatList.first.categoryName.validate();
        });
      }
    }).catchError((error) {
      toast(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    double partition = screenSizePartition(context);
    return Scaffold(
      appBar: CategoryAppBarComponent(
        mSubCatList: subCatList,
        title: "",
        selectedName: selectedName,
        onUpdate: (String? newValue) {
          subCatList.forEach((element) {
            if (element.categoryName == newValue) {
              selectedName = newValue.validate();
              selectedCategory = element.subCategoryId.validate();
              bookList.clear();
              isLoadingMoreData = true;
              setState(() {});
              if (newValue == ALL_BOOK) {
                future = getCategoryWiseBookDetail(
                  page: page,
                  categoryId: widget.categoryId.validate(),
                  books: bookList,
                  callback: (res) {
                    isLastPage = res;
                  },
                );
              } else {
                future = getCategoryWiseBookDetail(
                  page: page,
                  categoryId: widget.categoryId.validate(),
                  books: bookList,
                  subCategoryId: selectedCategory,
                  callback: (res) {
                    isLastPage = res;
                  },
                );
              }
            }
          });
        },
      ),
      body: Stack(
        children: [
          SnapHelperWidget<List<BookDetailResponse>>(
            future: future,
            errorWidget: NoDataWidget(title: "").center(),
            loadingWidget: AppLoaderWidget().center(),
            onSuccess: (data) {
              if (data.isEmpty) {
                return NoDataWidget(title: language!.noDataFound, image: no_data_view).center();
              }

              return AnimatedScrollView(
                listAnimationType: ListAnimationType.FadeIn,
                dragStartBehavior: DragStartBehavior.start,
                onNextPage: () {
                  if (!isLastPage) {
                    page++;
                    init();
                  }
                },
                children: [
                  Responsive(
                    mobile: Wrap(
                      spacing: 12,
                      runSpacing: 16,
                      children: List.generate(data.length, (index) {
                        BookDetailResponse? mData = data[index];
                        return BookComponent(bookData: mData, bookWidth: (context.width() / 2) - 22, isCenterBookInfo: true, isLeftDisTag: 10);
                      }),
                    ).paddingAll(defaultRadius),
                    web: WebCategoryWiseBookScreen(categoryWiseBookData: data, subCategoryName: selectedName, width: (context.width() / partition) - 97),
                    tablet: Wrap(
                      spacing: 8,
                      runSpacing: 16,
                      children: List.generate(data.length, (index) {
                        BookDetailResponse? mData = data[index];
                        return BookComponent(bookData: mData, bookWidth: (context.width() / 3) - 22, isCenterBookInfo: true, isLeftDisTag: 40);
                      }),
                    ).paddingAll(defaultRadius),
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Observer(
              builder: (context) {
                return AppLoaderWidget().visible(appStore.isLoading && page != 1).center();
              },
            ),
          ),
        ],
      ),
    );
  }
}

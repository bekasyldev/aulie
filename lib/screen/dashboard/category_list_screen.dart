import 'package:flutter/material.dart';
import 'package:granth_flutter/screen/dashboard/component/mobile_category_list_res_component.dart';
import 'package:granth_flutter/screen/dashboard/web_screen/category_list_screen_web.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryListScreen extends StatefulWidget {
  static String tag = '/CategoryListScreen';

  @override
  CategoryListScreenState createState() => CategoryListScreenState();
}

class CategoryListScreenState extends State<CategoryListScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double partition = screenSizePartition(context);
    return Scaffold(
      body: Responsive(
        mobile: MobileCategoryListResComponent(),
        web: WebCategoryListScreen(width: context.width() / partition - 100),
        tablet: MobileCategoryListResComponent(),
      ),
    );
  }
}

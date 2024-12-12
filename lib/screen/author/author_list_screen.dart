import 'package:flutter/material.dart';
import 'package:granth_flutter/screen/author/component/mobile_author_list_component.dart';
import 'package:granth_flutter/screen/author/web_screen/author_list_screen_web.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class AllAuthorListScreen extends StatefulWidget {
  static String tag = '/AuthorListScreen';

  @override
  AllAuthorListScreenState createState() => AllAuthorListScreenState();
}

class AllAuthorListScreenState extends State<AllAuthorListScreen> {
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
    double partition = screenSizePartition(context);
    return Scaffold(
      body: Responsive(
        mobile: MobileAuthorListComponent(),
        web: WebAuthorListScreen(width: context.width() / partition - 98),
        tablet: MobileAuthorListComponent(),
      ),
    );
  }
}

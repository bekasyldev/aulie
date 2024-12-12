import 'package:flutter/material.dart';
import 'package:granth_flutter/screen/book/component/mobile_view_all_book_res_component.dart';
import 'package:granth_flutter/screen/book/web_screen/view_all_book_screen_web.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class ViewAllBookScreen extends StatefulWidget {
  static String tag = '/ViewAllBookScreen';
  final String? type;
  final String? title;

  ViewAllBookScreen({this.type, this.title});

  @override
  ViewAllBookScreenState createState() => ViewAllBookScreenState();
}

class ViewAllBookScreenState extends State<ViewAllBookScreen> {
  double partition = 0;

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      init();
    });
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
    partition = screenSizePartition(context);
    return Scaffold(
      body: Responsive(
        mobile: MobileViewAllBookResComponent(type: widget.type, title: widget.title, width: (context.width() - 50) / 2),
        web: WebViewAllBookScreen(type: widget.type, title: widget.title, width: (context.width() / partition) - 100),
        tablet: MobileViewAllBookResComponent(type: widget.type, title: widget.title, width: (context.width() - 70) / partition),
      ),
    );
  }
}

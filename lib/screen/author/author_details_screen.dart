import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/author_model.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/author/component/mobile_author_details_component.dart';
import 'package:granth_flutter/screen/author/web_screen/author_details_screen_web.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthorDetailsScreen extends StatefulWidget {
  static String tag = '/AuthorDetailsScreen';
  final AuthorResponse? authorData;

  AuthorDetailsScreen({this.authorData});

  @override
  AuthorDetailsScreenState createState() => AuthorDetailsScreenState();
}

class AuthorDetailsScreenState extends State<AuthorDetailsScreen> {
  List<BookDetailResponse> authorBookList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    appStore.setLoading(true);
    await bookListApi(authorId: widget.authorData!.authorId.validate()).then((value) {
      authorBookList = value.data.validate();

      appStore.setLoading(false);
      setState(() {});
    }).catchError((e) {
      toast(e.toString());
      appStore.setLoading(false);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: MobileAuthorDetailsComponent(authorData: widget.authorData, authorBookList: authorBookList),
        web: WebAuthorDetailsScreen(authorData: widget.authorData, authorBookList: authorBookList),
        tablet: MobileAuthorDetailsComponent(authorData: widget.authorData, authorBookList: authorBookList),
      ),
    );
  }
}

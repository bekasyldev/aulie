import 'package:flutter/material.dart';
import 'package:granth_flutter/screen/author/component/author_detail_component_web.dart';
import 'package:granth_flutter/models/author_model.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/screen/author/component/author_detail_res_component.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthorDetailComponent extends StatefulWidget {
  static String tag = '/AuthorDetailComponent';
  final AuthorResponse? authorData;
  final List<BookDetailResponse>? authorBookList;

  AuthorDetailComponent({this.authorData, this.authorBookList});

  @override
  AuthorDetailComponentState createState() => AuthorDetailComponentState();
}

class AuthorDetailComponentState extends State<AuthorDetailComponent> {
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
    return Responsive(
      mobile: AuthorDetailResComponent(authorData: widget.authorData, authorBookList: widget.authorBookList),
      web: WebAuthorDetailComponent(authorData: widget.authorData, authorBookList: widget.authorBookList),
      tablet: AuthorDetailResComponent(authorData: widget.authorData, authorBookList: widget.authorBookList),
    );
  }
}

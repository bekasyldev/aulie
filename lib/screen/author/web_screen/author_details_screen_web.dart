import 'package:flutter/material.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/author_model.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/screen/author/component/author_detail_component.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class WebAuthorDetailsScreen extends StatelessWidget {
  final AuthorResponse? authorData;
  final List<BookDetailResponse>? authorBookList;

  WebAuthorDetailsScreen({this.authorData, this.authorBookList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("", elevation: 0, showBack: true, color: context.dividerColor.withOpacity(0.1)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WebBreadCrumbWidget(context, title: language!.authorDetails, subTitle1: language!.dashboard, subTitle2: language!.authorDetails),
            SizedBox(
              width: context.width(),
              child: AuthorDetailComponent(authorData: authorData, authorBookList: authorBookList),
            ),
            AppLoaderWidget().center().visible(appStore.isLoading),
          ],
        ),
      ),
    );
  }
}

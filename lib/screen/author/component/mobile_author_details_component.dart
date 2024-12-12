import 'package:flutter/material.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/screen/author/component/author_detail_component.dart';
import 'package:granth_flutter/models/author_model.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileAuthorDetailsComponent extends StatelessWidget {
  final AuthorResponse? authorData;
  final List<BookDetailResponse>? authorBookList;

  MobileAuthorDetailsComponent({this.authorData, this.authorBookList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        "",
        backWidget: Icon(Icons.arrow_back, color: Colors.white).onTap(() {
          finish(context);
        }),
        titleTextStyle: boldTextStyle(),
        elevation: 0,
        color: defaultPrimaryColor,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(child: AuthorDetailComponent(authorData: authorData, authorBookList: authorBookList)),
          AppLoaderWidget().center().visible(appStore.isLoading),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/component/no_data_found_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/author_list_model.dart';
import 'package:granth_flutter/models/author_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/author/author_details_screen.dart';
import 'package:granth_flutter/screen/author/component/all_authorlist_component.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class WebAuthorListScreen extends StatelessWidget {
  final double? width;

  WebAuthorListScreen({this.width});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('', elevation: 0, color: context.dividerColor.withOpacity(0.1)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WebBreadCrumbWidget(context, title: language!.authors, subTitle1: language!.dashboard, subTitle2: language!.authors),
            Container(
              width: context.width(),
              padding: EdgeInsets.only(bottom: 16),
              constraints: BoxConstraints(maxWidth: context.width() * 0.8, minWidth: context.width() * 0.6),
              child: FutureBuilder<AuthorListResponse>(
                future: getAuthorList(),
                builder: (_, snap) {
                  if (snap.hasData) {
                    if (snap.data!.authorListData!.isEmpty) NoDataFoundWidget();
                    return Wrap(
                      spacing: 22,
                      runSpacing: 22,
                      children: List.generate(snap.data!.authorListData!.length.validate(), (index) {
                        AuthorResponse mData = snap.data!.authorListData![index];
                        return SizedBox(
                          width: width,
                          child: AllAuthorListComponent(authorData: snap.data!.authorListData![index], isWebAuthor: true).onTap(
                            () {
                              AuthorDetailsScreen(authorData: mData).launch(context);
                            },
                          ),
                        );
                      }),
                    );
                  }
                  return snapWidgetHelper(snap, loadingWidget: AppLoaderWidget().center());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

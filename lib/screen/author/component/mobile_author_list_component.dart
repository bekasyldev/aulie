import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/component/no_data_found_widget.dart';
import 'package:granth_flutter/models/author_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/author/component/all_authorlist_component.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/author_list_model.dart';
import 'package:granth_flutter/screen/author/author_details_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileAuthorListComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language!.authors, elevation: 0),
      body: FutureBuilder<AuthorListResponse>(
        future: getAuthorList(),
        builder: (_, snap) {
          if (snap.hasData) {
            if (snap.data!.authorListData!.isEmpty) NoDataFoundWidget();
            return AnimatedListView(
              listAnimationType: ListAnimationType.FadeIn,
              dragStartBehavior: DragStartBehavior.start,
              padding: EdgeInsets.only(left: defaultRadius, right: defaultRadius, top: defaultRadius),
              itemCount: snap.data!.authorListData!.length.validate(),
              itemBuilder: (context, index) {
                AuthorResponse mData = snap.data!.authorListData![index];
                return AllAuthorListComponent(authorData: snap.data!.authorListData![index]).onTap(
                  () {
                    AuthorDetailsScreen(authorData: mData).launch(context);
                  },
                ).paddingBottom(defaultRadius);
              },
            );
          }
          return snapWidgetHelper(snap, loadingWidget: AppLoaderWidget().center());
        },
      ),
    );
  }
}

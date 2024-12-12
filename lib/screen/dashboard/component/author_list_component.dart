import 'package:flutter/material.dart';
import 'package:granth_flutter/screen/dashboard/component/author_component.dart';
import 'package:granth_flutter/screen/dashboard/component/see_all_component.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/author_model.dart';
import 'package:granth_flutter/screen/author/author_list_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthorListComponent extends StatelessWidget {
  final List<AuthorResponse>? authorList;

  AuthorListComponent({this.authorList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        SeeAllComponent(
          isShowSeeAll: true,
          title: language!.authors,
          onClick: () {
            AllAuthorListScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
          },
        ).paddingSymmetric(horizontal: 16),
        16.height,
        HorizontalList(
          itemCount: authorList!.length,
          spacing: isWeb ? 40 : 16,
          runSpacing: 0,
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            AuthorResponse authorData = authorList![index];
            return AuthorComponent(authorData: authorData);
          },
        )
      ],
    );
  }
}

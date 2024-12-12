import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class NoDataFoundWidget extends StatelessWidget {
  final String? image;
  final String? title;

  NoDataFoundWidget({this.image, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image ?? no_data_view, fit: BoxFit.cover, height: 200, width: 200).center(),
        8.height,
        Observer(builder: (context) {
          return Text(title ?? language!.noDataFound, style: boldTextStyle(color: appStore.isDarkMode ? Colors.white : Colors.black), textAlign: TextAlign.center);
        }),
      ],
    );
  }
}

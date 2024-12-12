import 'package:flutter/material.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:nb_utils/nb_utils.dart';

class RattingViewComponent extends StatelessWidget {
  final BookDetailResponse? bookDetailResponse;
  final bool? isCenterInfo;

  RattingViewComponent({this.bookDetailResponse, this.isCenterInfo = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isCenterInfo! ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        if (bookDetailResponse!.totalRating.validate().toString().isNotEmpty)
          RatingBarWidget(
            allowHalfRating: false,
            disable: true,
            itemCount: 5,
            size: 20,
            activeColor: Colors.amber,
            rating: bookDetailResponse!.totalRating.validate().toDouble(),
            onRatingChanged: (value) {
              //
            },
          ),
        8.width,
        Text("(" + bookDetailResponse!.totalRating.validate().toStringAsFixed(1).validate() + ")"),
      ],
    );
  }
}

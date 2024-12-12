import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class ReviewTextComponent extends StatefulWidget {
  static String tag = '/ReviewTextComponent';
  final String? label;
  final double? totalValue;
  final Color? color;
  final int? txtSize;
  final double? iconSize;
  final double? width;

  ReviewTextComponent({this.label, this.totalValue, this.color, this.txtSize, this.iconSize, this.width});

  @override
  ReviewTextComponentState createState() => ReviewTextComponentState();
}

class ReviewTextComponentState extends State<ReviewTextComponent> {
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
    return Row(
      children: [
        Container(width: 10, child: Text(widget.label.validate(), style: primaryTextStyle(size: widget.txtSize))),
        8.width,
        Icon(Icons.star, color: widget.color, size: widget.iconSize),
        4.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: context.width() * 0.8,
                  height: 8,
                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(16)),
                  child: Text(''),
                ),
                Container(
                  height: 8,
                  width: isWeb ? widget.width! * ((widget.totalValue).validate() / 100) * 0.7 : context.width() * ((widget.totalValue).validate() / 100) * 0.7,
                  decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.circular(16)),
                  child: Text(''),
                ),
              ],
            ),
          ],
        ).expand(),
      ],
    );
  }
}

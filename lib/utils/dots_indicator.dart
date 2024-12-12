// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  int currentIndex;

  double length;
  bool isCircle;
  Color? colorDisable;
  Color borderColor;
  Color? deActiveText;

  Color? activeText;

  DotsIndicator({
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
    required this.currentIndex,
    this.borderColor = Colors.transparent,
    this.color = Colors.white,
    this.colorDisable,
    this.isCircle = false,
    this.length = 100 / 2,
    this.deActiveText,
    this.activeText,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;
  final Color color;

  Widget _buildDot(int index) {
    return new Container(
      margin: EdgeInsets.symmetric(horizontal: 16 / 4),
      child: new Center(
        child: new Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? color
                : colorDisable == null
                    ? Colors.grey
                    : colorDisable,
            border: Border.all(color: borderColor, width: 0.4),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          width: length,
          height: isCircle ? length : 16 / 4,
          child: Text(
            "${index + 1}",
            textAlign: TextAlign.center,
            style: TextStyle(color: currentIndex == index ? activeText : deActiveText),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

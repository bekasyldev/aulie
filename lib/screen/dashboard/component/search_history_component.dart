import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchHistoryComponent extends StatefulWidget {
  static String tag = '/SearchHistoryComponent';
  List searchHistory = <String>[];
  Function onSearchHistory;

  SearchHistoryComponent(this.searchHistory, {required this.onSearchHistory});

  @override
  SearchHistoryComponentState createState() => SearchHistoryComponentState();
}

class SearchHistoryComponentState extends State<SearchHistoryComponent> {
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
    return Wrap(
      spacing: 8.0, // gap between adjacent chips
      runSpacing: 1.0, // gap between lines
      children: widget.searchHistory
          .map(
            (item) => GestureDetector(
              child: Chip(label: Text(item, style: TextStyle(color: white))),
              onTap: () {
                widget.onSearchHistory.call(item);
              },
            ),
          )
          .toList()
          .cast<Widget>(),
    );
  }
}

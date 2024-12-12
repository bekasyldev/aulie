import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:granth_flutter/main.dart';
import 'package:nb_utils/nb_utils.dart';

class PDFViewerScreen extends StatefulWidget {
  final String filePath;
  final String? bookName;
  final int? bookId;

  PDFViewerScreen({required this.filePath, this.bookName, this.bookId});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  int totalPage = 0;
  int currentPage = 0;
  late PDFViewController pdfCont;

  TextEditingController textEditingCont = TextEditingController();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    //
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        widget.bookName.validate(),
        elevation: 0,
        color: context.dividerColor.withOpacity(0.1),
        actions: [
          IconButton(
              onPressed: () async {
                await pdfCont.setPage(0);
              },
              icon: Icon(Icons.refresh, color: context.iconColor)),
        ],
      ),
      body: SizedBox(
        height: context.height(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PDFView(
              filePath: widget.filePath,
              pageSnap: false,
              swipeHorizontal: false,
              nightMode: appStore.isDarkMode,
              defaultPage: 0,
              onPageChanged: (page, total) {
                currentPage = page.validate();
                totalPage = total.validate();
                setState(() {});
              },
              onViewCreated: (PDFViewController pdfViewController) {
                setState(() {
                  pdfCont = pdfViewController;
                });
              },
              onPageError: (page, error) {
                log('Something gone wrong pdf');
              },
            ),
            Container(
              color: context.cardColor,
              padding: EdgeInsets.all(defaultRadius),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                    icon: const Icon(Icons.navigate_before),
                    onPressed: () async {
                      if (currentPage != 0) await pdfCont.setPage(currentPage - 1);
                    },
                  ),
                  Text("${currentPage + 1}/$totalPage", style: primaryTextStyle()).paddingSymmetric(horizontal: 16),
                  IconButton(
                    icon: const Icon(Icons.navigate_next),
                    onPressed: () async {
                      if (currentPage != totalPage) await pdfCont.setPage(currentPage + 1);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

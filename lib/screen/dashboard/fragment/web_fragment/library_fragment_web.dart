import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_scroll_behaviour.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class WebLibraryFragmentScreen extends StatefulWidget {
  @override
  _WebLibraryFragmentScreenState createState() => _WebLibraryFragmentScreenState();
}

class _WebLibraryFragmentScreenState extends State<WebLibraryFragmentScreen> {
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

  Widget buildNoDataWidget() {
    return Observer(builder: (context) {
      return SingleChildScrollView(
        child: NoDataWidget(
          image: warning,
          title: 'This will work only in Mobile!',
          titleTextStyle: boldTextStyle(color: appStore.isDarkMode ? Colors.white : null),
          imageSize: Size(40, 40),
        ),
      ).center();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: appStore.isLoggedIn ? 3 : 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              Observer(builder: (context) {
                return SliverAppBar(
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  expandedHeight: 40,
                  pinned: true,
                  titleSpacing: 16,
                  actions: <Widget>[],
                  bottom: TabBar(
                    automaticIndicatorColorAdjustment: false,
                    indicatorColor: defaultPrimaryColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: appStore.isDarkMode ? white : blackColor,
                    labelColor: defaultPrimaryColor,
                    isScrollable: false,
                    onTap: (index) {},
                    tabs: appStore.isLoggedIn
                        ? [
                            Tab(text: language!.sample),
                            Tab(text: language!.purchase),
                            Tab(text: language!.download),
                          ]
                        : [
                            Tab(text: language!.sample),
                            Tab(text: language!.download),
                          ],
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(language!.myLibrary, style: boldTextStyle(size: 22)),
                    titlePadding: EdgeInsets.only(bottom: 60, left: 16),
                  ),
                );
              })
            ];
          },
          body: ScrollConfiguration(
            behavior: AppScrollBehavior(),
            child: Stack(
              children: [
                appStore.isLoggedIn
                    ? TabBarView(
                        children: [
                          buildNoDataWidget(),
                          buildNoDataWidget(),
                          buildNoDataWidget(),
                        ],
                      )
                    : TabBarView(
                        children: [
                          buildNoDataWidget(),
                          buildNoDataWidget(),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

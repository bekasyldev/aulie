import 'package:flutter/material.dart';
import 'package:granth_flutter/screen/dashboard/mobile_dashboard_screen.dart';
import 'package:granth_flutter/screen/dashboard/web_screen/dashboard_screen_web.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardScreen extends StatefulWidget {
  static String tag = '/DashboardScreen';

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      child: Responsive(
        mobile: MobileDashboardScreen(),
        web: WebDashboardScreen(),
        tablet: MobileDashboardScreen(),
      ),
    );
  }
}

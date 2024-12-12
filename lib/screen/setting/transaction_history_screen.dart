import 'package:flutter/material.dart';
import 'package:granth_flutter/screen/setting/component/mobile_transaction_history_component.dart';
import 'package:granth_flutter/screen/setting/web_screen/transaction_history_screen_web.dart';
import 'package:nb_utils/nb_utils.dart';

class TransactionHistoryScreen extends StatefulWidget {
  static String tag = '/TransactionHistory';

  @override
  TransactionHistoryScreenState createState() => TransactionHistoryScreenState();
}

class TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
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
    return Scaffold(
      body: Responsive(
        mobile: MobileTransactionHistoryComponent(),
        web: WebTransactionHistoryScreen(),
        tablet: MobileTransactionHistoryComponent(),
      ),
    );
  }
}

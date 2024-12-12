import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/component/no_data_found_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/transaction_history_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/setting/component/trancation_history_component.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:nb_utils/nb_utils.dart';

class WebTransactionHistoryScreen extends StatelessWidget {
  const WebTransactionHistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        appBar: appBarWidget('', showBack: false, elevation: 0, color: context.dividerColor.withOpacity(0.1)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              WebBreadCrumbWidget(context, title: language!.transactionHistory, subTitle1: 'Home', subTitle2: language!.transactionHistory),
              FutureBuilder<TransactionHistoryResponse>(
                future: getTransactionDetails(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    if (snap.data!.transactionData!.isEmpty) return NoDataFoundWidget().center();
                    return AnimatedListView(
                      itemCount: snap.data!.transactionData!.length.validate(),
                      padding: EdgeInsets.only(left: defaultRadius, right: defaultRadius),
                      itemBuilder: (context, index) {
                        Transaction mData = snap.data!.transactionData![index];
                        return TransactionHistoryComponent(transactionData: mData).paddingBottom(defaultRadius);
                      },
                    );
                  }
                  return snapWidgetHelper(snap, loadingWidget: AppLoaderWidget().center());
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

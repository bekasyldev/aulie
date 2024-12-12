import 'package:flutter/material.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/component/no_data_found_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/transaction_history_model.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/setting/component/trancation_history_component.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileTransactionHistoryComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(language!.transactionHistory, elevation: 0),
      body: FutureBuilder<TransactionHistoryResponse>(
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
    );
  }
}

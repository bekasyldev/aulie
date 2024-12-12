import 'package:flutter/material.dart';
import 'package:granth_flutter/models/transaction_history_model.dart';
import 'package:granth_flutter/component/cache_image_widget.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class TransactionHistoryComponent extends StatefulWidget {
  static String tag = '/TransactionHistoryComponent';
  final Transaction? transactionData;

  TransactionHistoryComponent({this.transactionData});

  @override
  TransactionHistoryComponentState createState() => TransactionHistoryComponentState();
}

class TransactionHistoryComponentState extends State<TransactionHistoryComponent> {
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
    return Container(
      padding: EdgeInsets.all(16),
      width: context.width(),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: context.cardColor,
        border: Border.all(color: defaultPrimaryColor.withOpacity(0.3), width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.transactionData!.otherTransactionDetail!.txtPaymentId != null)
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: boxDecorationWithRoundedCorners(backgroundColor: defaultPrimaryColor.withOpacity(0.2)),
                  child: Text(
                    "#" + widget.transactionData!.otherTransactionDetail!.txtPaymentId.validate(),
                    style: primaryTextStyle(size: 12, color: defaultPrimaryColor),
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: boxDecorationWithRoundedCorners(backgroundColor: defaultPrimaryColor.withOpacity(0.2)),
                  child: Text(
                    "#" + widget.transactionData!.otherTransactionDetail!.txnIds.validate(),
                    style: primaryTextStyle(size: 12, color: defaultPrimaryColor),
                  ),
                ),
          16.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedImageWidget(
                url: widget.transactionData!.frontCover.validate(),
                height: 90,
                width: 70,
                fit: BoxFit.cover,
              ).cornerRadiusWithClipRRect(defaultRadius),
              16.width,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Marquee(
                        child: Text(widget.transactionData!.bookName.capitalizeFirstLetter().validate(), style: boldTextStyle(), maxLines: 1),
                      ).expand(),
                      8.width,
                    ],
                  ),
                  8.height,
                  Text(
                    widget.transactionData!.totalAmount.toCurrencyAmount(),
                    style: boldTextStyle(color: defaultPrimaryColor, size: 18),
                  ),
                  4.height,
                  Text(
                    formatDate(widget.transactionData!.datetime.validate()),
                    style: secondaryTextStyle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  8.height,
                  Text(
                    widget.transactionData!.paymentStatus.validate() == PAYMENT_STATUS_SUCCESS || widget.transactionData!.paymentStatus.validate() == 'approved' ? TRANSACTION_SUCCESS : TRANSACTION_FAILED,
                    style: boldTextStyle(color: widget.transactionData!.paymentStatus.validate() == PAYMENT_STATUS_SUCCESS || widget.transactionData!.paymentStatus.validate() == 'approved' ? Colors.green : redColor),
                  )
                ],
              ).expand()
            ],
          ),
        ],
      ),
    );
  }
}

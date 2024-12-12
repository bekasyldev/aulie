import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/models/payment_method_list_model.dart';
import 'package:granth_flutter/screen/book/epub_viewer_screen.dart';
import 'package:granth_flutter/screen/book/pdf_viewer_screen.dart';
import 'package:granth_flutter/utils/file_common.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:granth_flutter/utils/permissions.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

import '../models/downloaded_book.dart';
import '../models/font_size_model.dart';
import 'colors.dart';
import 'constants.dart';

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(
      id: 1,
      name: 'Қазақша',
      languageCode: 'kz',
      fullLanguageCode: 'kz-KZ',
      flag: 'images/flag/ic_kz.png',
    ),
    LanguageDataModel(
      id: 2,
      name: 'Русский',
      languageCode: 'ru',
      fullLanguageCode: 'ru-RU',
      flag: 'images/flag/ic_ru.png',
    ),
    LanguageDataModel(id: 3, name: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: 'images/flag/ic_us.png'),
  ];
}

List<String> rtlSupport = ['ar'];

List<PaymentMethodListModel> paymentModeListData() {
  List<PaymentMethodListModel> paymentModeList = [];
  paymentModeList.add(PaymentMethodListModel(title: "razorPay", image: razorpay_img));

//  paymentModeList.add(PaymentMethodListModel(title: "paytm", image: paytm_img));
  paymentModeList.add(PaymentMethodListModel(title: "paypal", image: pay_pal_img));
  paymentModeList.add(PaymentMethodListModel(title: "stripe", image: stripe_img));
  paymentModeList.add(PaymentMethodListModel(title: "flutterWave", image: flutter_wave_img));

  return paymentModeList;
}

InputDecoration inputDecoration(BuildContext context, {Widget? prefixIcon, String? hintText, double? borderRadius, Widget? preFixIcon, Widget? suffixIcon, bool labelText = true}) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: labelText ? hintText : '',
    labelStyle: secondaryTextStyle(),
    alignLabelWithHint: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: defaultPrimaryColor, width: 0.0),
    ),
    filled: true,
    fillColor: appStore.isDarkMode ? scaffoldSecondaryDark : textFiledFillColor,
    prefixIcon: preFixIcon,
    suffixIcon: suffixIcon ?? SizedBox(),
  );
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

///OneSignal Player id

setOneSignal() async {
  OneSignal.initialize(ONE_SIGNAL_APP_ID);
  OneSignal.Notifications.requestPermission(true);

  OneSignal.User.pushSubscription.optIn();

  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    OneSignal.Notifications.displayNotification(event.notification.notificationId);
    return event.notification.display();
  });
  OneSignal.User.pushSubscription.addObserver((stateChanges) async {
    if (stateChanges.current.id.validate().isNotEmpty) {
      setValue(PLAYER_ID, stateChanges.current.id.validate());
    }
  });
}

///Payment Status
String getPaymentStatus({String? status, String? method}) {
  if (status == PAYMENT_STATUS_SUCCESS) {
    return TRANSACTION_SUCCESS;
  } else if (status == PAYMENT_STATUS_FAILED) {
    return TRANSACTION_FAILED;
  } else if (status == PAYMENT_PAID) {
    return PAYMENT_FAILED;
  } else {
    return "";
  }
}

///Payment Color
Color setTransactionSuccess({required String status}) {
  if (status == TRANSACTION_SUCCESS) {
    return Colors.green;
  } else if (status == TRANSACTION_PENDING) {
    return Colors.yellow;
  } else if (status == TRANSACTION_FAILED) {
    return Colors.red;
  }

  return Colors.green;
}

Future addToSearchArray(searchText) async {
  String oldValue = getStringAsync(SEARCH_TEXT);
  String result = oldValue.toLowerCase();
  if (!result.contains(searchText)) {
    setValue(SEARCH_TEXT, oldValue + searchText + ",");
  }
}

Future<List<String>> getSearchValue() async {
  List<String> data = [];
  var searchString = getStringAsync(SEARCH_TEXT);
  searchString = searchString.trim().toLowerCase();

  data = searchString.trim().split(',');
  data.removeAt(data.length - 1);
  return data;
}

Future clearSearchHistory() async {
  await setValue(SEARCH_TEXT, "");
}

String formatDate(String? dateTime, {String format = DATE_FORMAT_4, String format2 = DATE_FORMAT_6}) {
  if (dateTime.validate().isNotEmpty) {
    final currentDate = DateTime.now();
    int currentYear = currentDate.year;
    int createdAtYear = DateTime.parse(dateTime.validate()).year;

    if (currentYear == createdAtYear) {
      return DateFormat(format).format(DateTime.parse(dateTime.validate()));
    } else {
      return DateFormat(format2).format(DateTime.parse(dateTime.validate()));
    }
  } else {
    return '';
  }
}

List<FontSizeModel> fontList() {
  List<FontSizeModel> fontSizeList = [];
  fontSizeList.add(FontSizeModel(fontName: "Small", fontSize: 18));
  fontSizeList.add(FontSizeModel(fontName: "Medium", fontSize: 22));
  fontSizeList.add(FontSizeModel(fontName: "Large", fontSize: 32));
  fontSizeList.add(FontSizeModel(fontName: "Extra Large", fontSize: 42));
  return fontSizeList;
}

void handleViewClick(BuildContext context, {bool isPDF = false, String? filePath, String? bookName, int? bookId}) async {
  isPDF = filePath.validate().isPdf;

  if (isPDF) {
    PDFViewerScreen(filePath: filePath.validate(), bookName: bookName.validate(), bookId: bookId).launch(context).then((value) {});
  } else if (filePath.validate().contains(".epub")) {
    await EPubViewerScreen(filePath: filePath.validate(), bookName: bookName.validate(), bookId: bookId).launch(context).then((value) {});
  } else {
    toast('Invalid File');
  }
}

Future<bool> checkAndroidVersionAndStoragePermission() async {
  if (Platform.isAndroid) {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
    if ((info.version.sdkInt) >= 33) {
      log('---------------------here----------------');
      // No need to ask this permission on Android 13 (API 33)
      return true;
    } else {
      return await Permissions.storageGranted();
    }
  } else {
    return await Permissions.storageGranted();
  }
}

Future<void> downloadBook(BuildContext context, {BookDetailResponse? bookDetailResponse, bool isSample = false}) async {
  String fileName = '';
  String finalFilePath = '';

  if (isWeb) {
    html.AnchorElement anchorElement = html.AnchorElement(href: bookDetailResponse!.fileSamplePath);
    anchorElement.download = 'Test File';
    anchorElement.click();
  } else {
    if (await checkAndroidVersionAndStoragePermission()) {
      fileName = await getBookFileName(
        bookDetailResponse!.bookId.toString().validate(),
        bookDetailResponse.filePath.validate(),
        isSample: false,
      );
      finalFilePath = await getBookFilePathFromName(fileName, isSampleFile: false);

      if (appStore.purchasedFileExist) {
        handleViewClick(
          context,
          bookId: bookDetailResponse.bookId.validate(),
          filePath: finalFilePath,
          bookName: bookDetailResponse.name.validate(),
        );
      } else {
        await downloadFile(
          context,
          filePath: bookDetailResponse.filePath.toString(),
          downloadFileName: fileName,
          onUpdate: (var percentage) {
            appStore.setDownloadPercentageValue(percentage);

            if (percentage < 100) {
              appStore.setDownloading(true);
              appStore.setPurchasesFileStatus(true);
            } else {
              appStore.setDownloading(false);
            }
          },
        ).then((value) async {
          String path = await localPath;
          final savedDir = Directory(path);
          bool hasExisted = await savedDir.exists();

          if (!hasExisted) {
            savedDir.create();
          }

          if (appStore.downloadPercentageStore == 100.00) {
            await insertIntoDb(
              userid: appStore.userId.toInt().validate(),
              bookId: bookDetailResponse.bookId.toString(),
              bookImage: bookDetailResponse.frontCover.validate(),
              bookName: fileName,
              authorName: bookDetailResponse.authorName.validate().toString(),
              bookPath: bookDetailResponse.filePath.validate(),
              filePath: finalFilePath,
              fileType: PURCHASED_BOOK,
            );

            handleViewClick(
              context,
              bookId: bookDetailResponse.bookId.validate().toInt(),
              filePath: finalFilePath,
              bookName: bookDetailResponse.name.validate(),
            );
          }
        }).catchError((error) {
          toast('Oops!Download Failed! Try Again after sometimes');
          appStore.setDownloading(false);
          return error;
        });
      }
    } else {
      Permission.manageExternalStorage.request();
    }
  }
}

Future<void> commonLaunchUrl(String url, {LaunchMode launchMode = LaunchMode.externalApplication}) async {
  await launchUrl(Uri.parse(url), mode: launchMode);
}

class HttpOverridesSkipCertificate extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) => super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
}

Widget WebBreadCrumbWidget(BuildContext context, {String? title, String? subTitle1, String? subTitle2, double? height, double? bottomSpace}) {
  return Container(
    width: context.width(),
    height: height ?? 150,
    color: context.dividerColor.withOpacity(0.1),
    padding: EdgeInsets.only(top: 10),
    child: Column(
      children: [
        Text(title.validate(), style: boldTextStyle(size: 30)),
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${subTitle1} - ', style: primaryTextStyle()),
            Text(subTitle2.validate(), style: primaryTextStyle(color: defaultPrimaryColor)),
          ],
        ),
      ],
    ),
  ).paddingBottom(bottomSpace ?? 50);
}

Widget customDialogue(BuildContext context, {String? title, required Widget child}) {
  return SimpleDialog(
    backgroundColor: appStore.isDarkMode ? scaffoldDarkColor : Colors.white,
    contentPadding: EdgeInsets.all(30),
    children: [
      ConstrainedBox(
        constraints: BoxConstraints(maxHeight: context.height() * 0.6, maxWidth: context.width() * 0.3),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title.validate(), style: boldTextStyle(size: 18)),
                    IconButton(
                      onPressed: () => finish(context),
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(child: child),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

double screenSizePartition(BuildContext context) {
  double size = context.width();
  int partition = 0;

  if (size < 1022) {
    partition = 3;
  } else if (size < 900) {
    partition = 2;
  } else {
    partition = 4;
  }

  return partition.toDouble();
}

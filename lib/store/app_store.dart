import 'package:flutter/material.dart';
import 'package:granth_flutter/locale/app_localizations.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/utils/colors.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';

import '../configs.dart';
import '../utils/constants.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  String selectedLanguageCode = DEFAULT_LANGUAGE;

  @observable
  bool isDarkMode = false;

  @observable
  bool isFirstTime = true;

  @observable
  bool isDisableNotification = false;

  @observable
  int bottomNavigationBarIndex = 0;

  @observable
  int tabBarIndex = 0;

  @observable
  bool isLoggedIn = false;

  @observable
  bool sampleFileExist = false;

  @observable
  bool purchasedFileExist = false;

  @observable
  bool isLoading = false;

  @observable
  bool isDownloading = false;

  @observable
  String token = '';

  @observable
  String userName = '';

  @observable
  String name = '';

  @observable
  String userEmail = '';

  @observable
  String userProfile = '';

  @observable
  String userContactNumber = '';

  @observable
  int userId = 0;

  @observable
  String selectPaymentMode = '';

  @observable
  int pageVariant = 1;

  @observable
  double downloadPercentageStore = 0.0;

  @observable
  List<String> recentSearch = <String>[];

  @observable
  ObservableList<BookDetailResponse> bookWishList = ObservableList<BookDetailResponse>();

  @observable
  int cartCount = 0;

  @observable
  double total = 0;

  @observable
  double payableAmount = 0;

  @computed
  bool get isNetworkConnected => !connectivityResult.contains(ConnectivityResult.none);

  @observable
  List<ConnectivityResult> connectivityResult = [];

  @observable
  bool isAddToCart = false;

  @action
  Future<void> setCartCount(int value) async {
    cartCount = value;
    await setValue(CART_COUNT, value);
  }

  @action
  Future<void> setRecentSearchData(List<String> data) async {
    recentSearch = data;
    await setValue(SEARCH_TEXT, data);
  }

  @action
  Future<void> setLanguage(String val) async {
    try {
      print('Setting language to: $val');
      selectedLanguageCode = val;
      selectedLanguageDataModel = getSelectedLanguageModel();
      
      await setValue(SELECTED_LANGUAGE_CODE, selectedLanguageCode);
      
      language = await AppLocalizations().load(Locale(selectedLanguageCode));
      print('Language set successfully to: $selectedLanguageCode');
    } catch (e) {
      print('Error setting language: $e');
      // Fallback to default language
      selectedLanguageCode = DEFAULT_LANGUAGE;
    }
  }

  @action
  Future<void> setDisplayWalkThrough(bool val) async {
    isFirstTime = val;
    await setValue(IS_EXIST_IN_CART, isFirstTime);
  }

  @action
  Future<void> setPageVariant(int val) async {
    pageVariant = val;
    await setValue(PAGE_VARIANT, pageVariant);
  }

  @action
  Future<void> setDownloadPercentageValue(double val) async {
    downloadPercentageStore = val;
    await setValue(DOWNLOAD_PERCENTAGE, downloadPercentageStore);
  }

  @action
  void setBottomNavigationBarIndex(int index) {
    bottomNavigationBarIndex = index;
  }

  @action
  void setTabBarIndex(int index) {
    tabBarIndex = index;
  }

  @action
  Future<void> setDisableNotification(bool val) async {
    isDisableNotification = val;
    await setValue(IS_NOTIFICATION, isDisableNotification);
  }

  @action
  Future<void> setSampleFileStatus(bool val) async {
    sampleFileExist = val;
    await setValue(CHECK_SAMPLE_FILE, sampleFileExist);
  }

  @action
  Future<void> setPurchasesFileStatus(bool val) async {
    purchasedFileExist = val;
    await setValue(CHECK_PURCHASE_FILE, purchasedFileExist);
  }

  @action
  Future<void> setLoggedIn(bool val, {bool isInitializing = false}) async {
    isLoggedIn = val;
    if (!isInitializing) await setValue(IS_LOGGED_IN, val);
  }

  @action
  Future<void> setLoading(bool val) async {
    isLoading = val;
    await setValue(IS_LOADING, isLoading);
  }

  @action
  Future<void> setDownloading(bool val) async {
    isDownloading = val;
    await setValue(IS_DOWNLOADING, isDownloading);
  }

  @action
  Future<void> setToken(String val, {bool isInitializing = false}) async {
    token = val;
    if (!isInitializing) await setValue(TOKEN, val);
  }

  @action
  Future<void> setDarkMode(bool val) async {
    isDarkMode = val;
    await setValue(IS_DARK_MODE, isDarkMode);

    if (isDarkMode) {
      textPrimaryColorGlobal = Colors.white;
      textSecondaryColorGlobal = textSecondaryColor;
      defaultLoaderBgColorGlobal = scaffoldSecondaryDark;
      appButtonBackgroundColorGlobal = appButtonColorDark;
      shadowColorGlobal = Colors.white12;
      defaultBlurRadius = 4;
      defaultSpreadRadius = 4;
      appBarBackgroundColorGlobal = Color(0xFF090909);
    } else {
      textPrimaryColorGlobal = textPrimaryColor;
      textSecondaryColorGlobal = textSecondaryColor;
      defaultLoaderBgColorGlobal = secondaryPrimaryColor;
      appButtonBackgroundColorGlobal = Colors.white;
      shadowColorGlobal = Colors.red;
      defaultBlurRadius = 4;
      defaultSpreadRadius = 4;
      appBarBackgroundColorGlobal = secondaryPrimaryColor;
    }
  }

  @action
  Future<void> setUserName(String val, {bool isInitializing = false}) async {
    userName = val;
    if (!isInitializing) await setValue(USER_NAME, val);
  }

  @action
  Future<void> setName(String val, {bool isInitializing = false}) async {
    name = val;
    if (!isInitializing) await setValue(NAME, val);
  }

  @action
  Future<void> setUserEmail(String val, {bool isInitializing = false}) async {
    userEmail = val;
    if (!isInitializing) await setValue(USER_EMAIL, val);
  }

  @action
  Future<void> setUserProfile(String val, {bool isInitializing = false}) async {
    userProfile = val;
    if (!isInitializing) await setValue(USER_PROFILE, val);
  }

  @action
  Future<void> setUserContactNumber(String val, {bool isInitializing = false}) async {
    userContactNumber = val;
    if (!isInitializing) await setValue(USER_CONTACT_NUMBER, val);
  }

  @action
  Future<void> setUserId(int val, {bool isInitializing = false}) async {
    userId = val;
    if (!isInitializing) await setValue(USER_ID, val);
  }

  @action
  Future<void> setPaymentMode(String val) async {
    selectPaymentMode = val;
    await setValue(SELECTED_PAYMENT_MODE, selectPaymentMode);
  }

  @action
  void setConnectionState(List<ConnectivityResult> val) {
    connectivityResult = val;
  }

  @action
  Future<void> setPayableAmount(double value) async {
    payableAmount = value;
    await setValue(CART_TOTAL, value);
  }

  @action
  Future<void> setAddToCart(bool val) async {
    isAddToCart = val;
    await setValue(IS_ADD_TO_CART, val);
  }
}

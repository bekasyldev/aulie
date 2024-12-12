// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  Computed<bool>? _$isNetworkConnectedComputed;

  @override
  bool get isNetworkConnected => (_$isNetworkConnectedComputed ??=
      Computed<bool>(() => super.isNetworkConnected,
          name: '_AppStore.isNetworkConnected'))
      .value;

  late final _$selectedLanguageCodeAtom =
  Atom(name: '_AppStore.selectedLanguageCode', context: context);

  @override
  String get selectedLanguageCode {
    _$selectedLanguageCodeAtom.reportRead();
    return super.selectedLanguageCode;
  }

  @override
  set selectedLanguageCode(String value) {
    _$selectedLanguageCodeAtom.reportWrite(value, super.selectedLanguageCode,
            () {
          super.selectedLanguageCode = value;
        });
  }

  late final _$isDarkModeAtom =
  Atom(name: '_AppStore.isDarkMode', context: context);

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  late final _$isFirstTimeAtom =
  Atom(name: '_AppStore.isFirstTime', context: context);

  @override
  bool get isFirstTime {
    _$isFirstTimeAtom.reportRead();
    return super.isFirstTime;
  }

  @override
  set isFirstTime(bool value) {
    _$isFirstTimeAtom.reportWrite(value, super.isFirstTime, () {
      super.isFirstTime = value;
    });
  }

  late final _$isDisableNotificationAtom =
  Atom(name: '_AppStore.isDisableNotification', context: context);

  @override
  bool get isDisableNotification {
    _$isDisableNotificationAtom.reportRead();
    return super.isDisableNotification;
  }

  @override
  set isDisableNotification(bool value) {
    _$isDisableNotificationAtom.reportWrite(value, super.isDisableNotification,
            () {
          super.isDisableNotification = value;
        });
  }

  late final _$bottomNavigationBarIndexAtom =
  Atom(name: '_AppStore.bottomNavigationBarIndex', context: context);

  @override
  int get bottomNavigationBarIndex {
    _$bottomNavigationBarIndexAtom.reportRead();
    return super.bottomNavigationBarIndex;
  }

  @override
  set bottomNavigationBarIndex(int value) {
    _$bottomNavigationBarIndexAtom
        .reportWrite(value, super.bottomNavigationBarIndex, () {
      super.bottomNavigationBarIndex = value;
    });
  }

  late final _$tabBarIndexAtom =
  Atom(name: '_AppStore.tabBarIndex', context: context);

  @override
  int get tabBarIndex {
    _$tabBarIndexAtom.reportRead();
    return super.tabBarIndex;
  }

  @override
  set tabBarIndex(int value) {
    _$tabBarIndexAtom.reportWrite(value, super.tabBarIndex, () {
      super.tabBarIndex = value;
    });
  }

  late final _$isLoggedInAtom =
  Atom(name: '_AppStore.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$sampleFileExistAtom =
  Atom(name: '_AppStore.sampleFileExist', context: context);

  @override
  bool get sampleFileExist {
    _$sampleFileExistAtom.reportRead();
    return super.sampleFileExist;
  }

  @override
  set sampleFileExist(bool value) {
    _$sampleFileExistAtom.reportWrite(value, super.sampleFileExist, () {
      super.sampleFileExist = value;
    });
  }

  late final _$purchasedFileExistAtom =
  Atom(name: '_AppStore.purchasedFileExist', context: context);

  @override
  bool get purchasedFileExist {
    _$purchasedFileExistAtom.reportRead();
    return super.purchasedFileExist;
  }

  @override
  set purchasedFileExist(bool value) {
    _$purchasedFileExistAtom.reportWrite(value, super.purchasedFileExist, () {
      super.purchasedFileExist = value;
    });
  }

  late final _$isLoadingAtom =
  Atom(name: '_AppStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isDownloadingAtom =
  Atom(name: '_AppStore.isDownloading', context: context);

  @override
  bool get isDownloading {
    _$isDownloadingAtom.reportRead();
    return super.isDownloading;
  }

  @override
  set isDownloading(bool value) {
    _$isDownloadingAtom.reportWrite(value, super.isDownloading, () {
      super.isDownloading = value;
    });
  }

  late final _$tokenAtom = Atom(name: '_AppStore.token', context: context);

  @override
  String get token {
    _$tokenAtom.reportRead();
    return super.token;
  }

  @override
  set token(String value) {
    _$tokenAtom.reportWrite(value, super.token, () {
      super.token = value;
    });
  }

  late final _$userNameAtom =
  Atom(name: '_AppStore.userName', context: context);

  @override
  String get userName {
    _$userNameAtom.reportRead();
    return super.userName;
  }

  @override
  set userName(String value) {
    _$userNameAtom.reportWrite(value, super.userName, () {
      super.userName = value;
    });
  }

  late final _$nameAtom = Atom(name: '_AppStore.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$userEmailAtom =
  Atom(name: '_AppStore.userEmail', context: context);

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$userProfileAtom =
  Atom(name: '_AppStore.userProfile', context: context);

  @override
  String get userProfile {
    _$userProfileAtom.reportRead();
    return super.userProfile;
  }

  @override
  set userProfile(String value) {
    _$userProfileAtom.reportWrite(value, super.userProfile, () {
      super.userProfile = value;
    });
  }

  late final _$userContactNumberAtom =
  Atom(name: '_AppStore.userContactNumber', context: context);

  @override
  String get userContactNumber {
    _$userContactNumberAtom.reportRead();
    return super.userContactNumber;
  }

  @override
  set userContactNumber(String value) {
    _$userContactNumberAtom.reportWrite(value, super.userContactNumber, () {
      super.userContactNumber = value;
    });
  }

  late final _$userIdAtom = Atom(name: '_AppStore.userId', context: context);

  @override
  int get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(int value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  late final _$selectPaymentModeAtom =
  Atom(name: '_AppStore.selectPaymentMode', context: context);

  @override
  String get selectPaymentMode {
    _$selectPaymentModeAtom.reportRead();
    return super.selectPaymentMode;
  }

  @override
  set selectPaymentMode(String value) {
    _$selectPaymentModeAtom.reportWrite(value, super.selectPaymentMode, () {
      super.selectPaymentMode = value;
    });
  }

  late final _$pageVariantAtom =
  Atom(name: '_AppStore.pageVariant', context: context);

  @override
  int get pageVariant {
    _$pageVariantAtom.reportRead();
    return super.pageVariant;
  }

  @override
  set pageVariant(int value) {
    _$pageVariantAtom.reportWrite(value, super.pageVariant, () {
      super.pageVariant = value;
    });
  }

  late final _$downloadPercentageStoreAtom =
  Atom(name: '_AppStore.downloadPercentageStore', context: context);

  @override
  double get downloadPercentageStore {
    _$downloadPercentageStoreAtom.reportRead();
    return super.downloadPercentageStore;
  }

  @override
  set downloadPercentageStore(double value) {
    _$downloadPercentageStoreAtom
        .reportWrite(value, super.downloadPercentageStore, () {
      super.downloadPercentageStore = value;
    });
  }

  late final _$recentSearchAtom =
  Atom(name: '_AppStore.recentSearch', context: context);

  @override
  List<String> get recentSearch {
    _$recentSearchAtom.reportRead();
    return super.recentSearch;
  }

  @override
  set recentSearch(List<String> value) {
    _$recentSearchAtom.reportWrite(value, super.recentSearch, () {
      super.recentSearch = value;
    });
  }

  late final _$bookWishListAtom =
  Atom(name: '_AppStore.bookWishList', context: context);

  @override
  ObservableList<BookDetailResponse> get bookWishList {
    _$bookWishListAtom.reportRead();
    return super.bookWishList;
  }

  @override
  set bookWishList(ObservableList<BookDetailResponse> value) {
    _$bookWishListAtom.reportWrite(value, super.bookWishList, () {
      super.bookWishList = value;
    });
  }

  late final _$cartCountAtom =
  Atom(name: '_AppStore.cartCount', context: context);

  @override
  int get cartCount {
    _$cartCountAtom.reportRead();
    return super.cartCount;
  }

  @override
  set cartCount(int value) {
    _$cartCountAtom.reportWrite(value, super.cartCount, () {
      super.cartCount = value;
    });
  }

  late final _$totalAtom = Atom(name: '_AppStore.total', context: context);

  @override
  double get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(double value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  late final _$payableAmountAtom =
  Atom(name: '_AppStore.payableAmount', context: context);

  @override
  double get payableAmount {
    _$payableAmountAtom.reportRead();
    return super.payableAmount;
  }

  @override
  set payableAmount(double value) {
    _$payableAmountAtom.reportWrite(value, super.payableAmount, () {
      super.payableAmount = value;
    });
  }

  late final _$connectivityResultAtom =
  Atom(name: '_AppStore.connectivityResult', context: context);

  @override
  List<ConnectivityResult> get connectivityResult {
    _$connectivityResultAtom.reportRead();
    return super.connectivityResult;
  }

  @override
  set connectivityResult(List<ConnectivityResult> value) {
    _$connectivityResultAtom.reportWrite(value, super.connectivityResult, () {
      super.connectivityResult = value;
    });
  }

  late final _$isAddToCartAtom =
  Atom(name: '_AppStore.isAddToCart', context: context);

  @override
  bool get isAddToCart {
    _$isAddToCartAtom.reportRead();
    return super.isAddToCart;
  }

  @override
  set isAddToCart(bool value) {
    _$isAddToCartAtom.reportWrite(value, super.isAddToCart, () {
      super.isAddToCart = value;
    });
  }

  late final _$setCartCountAsyncAction =
  AsyncAction('_AppStore.setCartCount', context: context);

  @override
  Future<void> setCartCount(int value) {
    return _$setCartCountAsyncAction.run(() => super.setCartCount(value));
  }

  late final _$setRecentSearchDataAsyncAction =
  AsyncAction('_AppStore.setRecentSearchData', context: context);

  @override
  Future<void> setRecentSearchData(List<String> data) {
    return _$setRecentSearchDataAsyncAction
        .run(() => super.setRecentSearchData(data));
  }

  late final _$setLanguageAsyncAction =
  AsyncAction('_AppStore.setLanguage', context: context);

  @override
  Future<void> setLanguage(String val) {
    return _$setLanguageAsyncAction.run(() => super.setLanguage(val));
  }

  late final _$setDisplayWalkThroughAsyncAction =
  AsyncAction('_AppStore.setDisplayWalkThrough', context: context);

  @override
  Future<void> setDisplayWalkThrough(bool val) {
    return _$setDisplayWalkThroughAsyncAction
        .run(() => super.setDisplayWalkThrough(val));
  }

  late final _$setPageVariantAsyncAction =
  AsyncAction('_AppStore.setPageVariant', context: context);

  @override
  Future<void> setPageVariant(int val) {
    return _$setPageVariantAsyncAction.run(() => super.setPageVariant(val));
  }

  late final _$setDownloadPercentageValueAsyncAction =
  AsyncAction('_AppStore.setDownloadPercentageValue', context: context);

  @override
  Future<void> setDownloadPercentageValue(double val) {
    return _$setDownloadPercentageValueAsyncAction
        .run(() => super.setDownloadPercentageValue(val));
  }

  late final _$setDisableNotificationAsyncAction =
  AsyncAction('_AppStore.setDisableNotification', context: context);

  @override
  Future<void> setDisableNotification(bool val) {
    return _$setDisableNotificationAsyncAction
        .run(() => super.setDisableNotification(val));
  }

  late final _$setSampleFileStatusAsyncAction =
  AsyncAction('_AppStore.setSampleFileStatus', context: context);

  @override
  Future<void> setSampleFileStatus(bool val) {
    return _$setSampleFileStatusAsyncAction
        .run(() => super.setSampleFileStatus(val));
  }

  late final _$setPurchasesFileStatusAsyncAction =
  AsyncAction('_AppStore.setPurchasesFileStatus', context: context);

  @override
  Future<void> setPurchasesFileStatus(bool val) {
    return _$setPurchasesFileStatusAsyncAction
        .run(() => super.setPurchasesFileStatus(val));
  }

  late final _$setLoggedInAsyncAction =
  AsyncAction('_AppStore.setLoggedIn', context: context);

  @override
  Future<void> setLoggedIn(bool val, {bool isInitializing = false}) {
    return _$setLoggedInAsyncAction
        .run(() => super.setLoggedIn(val, isInitializing: isInitializing));
  }

  late final _$setLoadingAsyncAction =
  AsyncAction('_AppStore.setLoading', context: context);

  @override
  Future<void> setLoading(bool val) {
    return _$setLoadingAsyncAction.run(() => super.setLoading(val));
  }

  late final _$setDownloadingAsyncAction =
  AsyncAction('_AppStore.setDownloading', context: context);

  @override
  Future<void> setDownloading(bool val) {
    return _$setDownloadingAsyncAction.run(() => super.setDownloading(val));
  }

  late final _$setTokenAsyncAction =
  AsyncAction('_AppStore.setToken', context: context);

  @override
  Future<void> setToken(String val, {bool isInitializing = false}) {
    return _$setTokenAsyncAction
        .run(() => super.setToken(val, isInitializing: isInitializing));
  }

  late final _$setDarkModeAsyncAction =
  AsyncAction('_AppStore.setDarkMode', context: context);

  @override
  Future<void> setDarkMode(bool val) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(val));
  }

  late final _$setUserNameAsyncAction =
  AsyncAction('_AppStore.setUserName', context: context);

  @override
  Future<void> setUserName(String val, {bool isInitializing = false}) {
    return _$setUserNameAsyncAction
        .run(() => super.setUserName(val, isInitializing: isInitializing));
  }

  late final _$setNameAsyncAction =
  AsyncAction('_AppStore.setName', context: context);

  @override
  Future<void> setName(String val, {bool isInitializing = false}) {
    return _$setNameAsyncAction
        .run(() => super.setName(val, isInitializing: isInitializing));
  }

  late final _$setUserEmailAsyncAction =
  AsyncAction('_AppStore.setUserEmail', context: context);

  @override
  Future<void> setUserEmail(String val, {bool isInitializing = false}) {
    return _$setUserEmailAsyncAction
        .run(() => super.setUserEmail(val, isInitializing: isInitializing));
  }

  late final _$setUserProfileAsyncAction =
  AsyncAction('_AppStore.setUserProfile', context: context);

  @override
  Future<void> setUserProfile(String val, {bool isInitializing = false}) {
    return _$setUserProfileAsyncAction
        .run(() => super.setUserProfile(val, isInitializing: isInitializing));
  }

  late final _$setUserContactNumberAsyncAction =
  AsyncAction('_AppStore.setUserContactNumber', context: context);

  @override
  Future<void> setUserContactNumber(String val, {bool isInitializing = false}) {
    return _$setUserContactNumberAsyncAction.run(
            () => super.setUserContactNumber(val, isInitializing: isInitializing));
  }

  late final _$setUserIdAsyncAction =
  AsyncAction('_AppStore.setUserId', context: context);

  @override
  Future<void> setUserId(int val, {bool isInitializing = false}) {
    return _$setUserIdAsyncAction
        .run(() => super.setUserId(val, isInitializing: isInitializing));
  }

  late final _$setPaymentModeAsyncAction =
  AsyncAction('_AppStore.setPaymentMode', context: context);

  @override
  Future<void> setPaymentMode(String val) {
    return _$setPaymentModeAsyncAction.run(() => super.setPaymentMode(val));
  }

  late final _$setPayableAmountAsyncAction =
  AsyncAction('_AppStore.setPayableAmount', context: context);

  @override
  Future<void> setPayableAmount(double value) {
    return _$setPayableAmountAsyncAction
        .run(() => super.setPayableAmount(value));
  }

  late final _$setAddToCartAsyncAction =
  AsyncAction('_AppStore.setAddToCart', context: context);

  @override
  Future<void> setAddToCart(bool val) {
    return _$setAddToCartAsyncAction.run(() => super.setAddToCart(val));
  }

  late final _$_AppStoreActionController =
  ActionController(name: '_AppStore', context: context);

  @override
  void setBottomNavigationBarIndex(int index) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setBottomNavigationBarIndex');
    try {
      return super.setBottomNavigationBarIndex(index);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTabBarIndex(int index) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setTabBarIndex');
    try {
      return super.setTabBarIndex(index);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConnectionState(List<ConnectivityResult> val) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setConnectionState');
    try {
      return super.setConnectionState(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedLanguageCode: ${selectedLanguageCode},
isDarkMode: ${isDarkMode},
isFirstTime: ${isFirstTime},
isDisableNotification: ${isDisableNotification},
bottomNavigationBarIndex: ${bottomNavigationBarIndex},
tabBarIndex: ${tabBarIndex},
isLoggedIn: ${isLoggedIn},
sampleFileExist: ${sampleFileExist},
purchasedFileExist: ${purchasedFileExist},
isLoading: ${isLoading},
isDownloading: ${isDownloading},
token: ${token},
userName: ${userName},
name: ${name},
userEmail: ${userEmail},
userProfile: ${userProfile},
userContactNumber: ${userContactNumber},
userId: ${userId},
selectPaymentMode: ${selectPaymentMode},
pageVariant: ${pageVariant},
downloadPercentageStore: ${downloadPercentageStore},
recentSearch: ${recentSearch},
bookWishList: ${bookWishList},
cartCount: ${cartCount},
total: ${total},
payableAmount: ${payableAmount},
connectivityResult: ${connectivityResult},
isAddToCart: ${isAddToCart},
isNetworkConnected: ${isNetworkConnected}
    ''';
  }
}

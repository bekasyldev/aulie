import 'package:flutter/material.dart';

abstract class BaseLanguage {
  static BaseLanguage of(BuildContext context) => Localizations.of<BaseLanguage>(context, BaseLanguage)!;

  String get createYourAccount;

  String get name;

  String get userName;

  String get email;

  String get contactNumber;

  String get password;

  String get confirmPassword;

  String get confirmPasswordRequired;

  String get passwordDoesnTMatch;

  String get login;

  String get loginSuccessfully;

  String get loginToYourAccount;

  String get dashboard;

  String get topSearchBooks;

  String get popularBooks;

  String get topPopularBooks;

  String get topSellBooks;

  String get categories;

  String get recommendedBooks;

  String get authors;

  String get authorDetails;

  String get aboutMe;

  String get authorBook;

  String get reviews;

  String get noDataFound;

  String get topReviews;

  String get writeReview;

  String get overview;

  String get information;

  String get youMayAlsoLike;

  String get currentPassword;

  String get newPassword;

  String get thisFieldIsRequired;

  String get passwordMustBeSame;

  String get chooseDetailPageVariant;

  String get enterYourName;

  String get enterYourUsername;

  String get enterYourEmail;

  String get enterYourMobileNumber;

  String get updateProfile;

  String get feedback;

  String get enterYourNewEmail;

  String get enterYourMessage;

  String get submit;

  String get noInternet;

  String get searchBooks;

  String get searchResultFor;

  String get searchForBooksBy;

  String get changeYourPassword;

  String get transactionHistory;

  String get transactionHistoryReport;

  String get changePassword;

  String get appLanguage;

  String get changeYourLanguage;

  String get appTheme;

  String get tapToEnableLightMode;

  String get tapToEnableDarkMode;

  String get animationMadeEvenBetter;

  String get disablePushNotification;

  String get tapToEnableNotification;

  String get tapToDisableNotification;

  String get logout;

  String get areYouSureWantToLogout;

  String get yes;

  String get no;

  String get placeOrder;

  String get paymentMethod;

  String get paymentDetails;

  String get designation;

  String get areYouSureWant;

  String get category;

  String get price;

  String get removed;

  String get added;

  String get viewSample;

  String get downloadSample;

  String get pleaseWait;

  String get addToCart;

  String get readBook;

  String get areYouSureWantToRemoveCart;

  String get fontSize;

  String get set;

  String get freeDailyBook;

  String get getItNow;

  String get created;

  String get publisher;

  String get availableFormat;

  String get totalPage;

  String get edit;

  String get delete;

  String get recentSearch;

  String get clearAll;

  String get seeAll;

  String get hey;

  String get loggedIn;

  String get chooseTheme;

  String get yourReview;

  String get areYouSureWantToDelete;

  String get language;

  String get myCart;

  String get sample;

  String get purchase;

  String get download;

  String get myLibrary;

  String get noSampleBooksDownload;

  String get noPurchasedBookAvailable;

  String get introduction;

  String get camera;

  String get gallery;

  String get forgotPassword;

  String get lblForgotPassword;

  String get donTHaveAnAccount;

  String get register;

  String get joinNow;

  String get alreadyHaveAnAccount;

  String get youCanReadBooksEasily;

  String get youCanDownloadBooks;

  String get youCanReadBooks;

  String get readBookAnywhere;

  String get downloadBooks;

  String get offlineBookRead;

  String get next;

  String get lblContinue;

  String get myWishlist;

  String get free;

  String get downloading;

  String get totalMrp;

  String get discount;

  String get total;

  String get signInToContinue;

  String get termsConditions;

  String get rateUs;

  String get share;

  String get aboutApp;

  String get cancel;

  String get editProfile;

  String get aboutUs;

  String get buyNow;

  String get areYouSureWantToRemoveReview;

  String get processing;

  String get transactionSuccessfully;

  String get appthemeLight;

  String get appthemeDark;

  String get appthemeDefault;

  String get books;

  String get createANewPassword;

  String get youNewPasswordMust;

  String get oldPassword;

  String get pleaseEnterInfoTo;

  String get weHaveSentA;

  String get justEnterTheEmail;

  String get message;

  String get getStarted;

  String get goToCart;

  String get cart;

  String get profile;

  String get library;
}

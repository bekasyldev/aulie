import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/models/all_book_details_model.dart';
import 'package:granth_flutter/models/author_list_model.dart';
import 'package:granth_flutter/models/bookdetail_model.dart';
import 'package:granth_flutter/models/cart_response.dart';
import 'package:granth_flutter/models/category_list_model.dart';
import 'package:granth_flutter/models/dashboard_model.dart';
import 'package:granth_flutter/models/login_model.dart';
import 'package:granth_flutter/models/transaction_history_model.dart';
import 'package:granth_flutter/network/network_utils.dart';
import 'package:granth_flutter/screen/dashboard/dashboard_screen.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';

import '../models/base_model.dart';
import '../models/category_model.dart';
import '../models/category_wise_book_model.dart';
import '../models/rating_model.dart';
import '../configs.dart';
import '../models/verify_transaction_response.dart';

///region Login Api
Future<LoginResponse> login(Map request) async {
  return LoginResponse.fromJson(await (handleResponse(await buildHttpResponse('login', request: request, method: HttpMethod.POST))));
}

///Change Password Api
Future<void> saveUserData(UserData data) async {
  if (data.apiToken.validate().isNotEmpty) await appStore.setToken(data.apiToken.validate());
  await appStore.setUserId(data.id.validate());
  await appStore.setName(data.name.validate());
  await appStore.setUserEmail(data.email.validate());
  await appStore.setUserName(data.userName.validate());
  await appStore.setUserProfile(data.image.validate());
  await appStore.setUserContactNumber(data.contactNumber.validate());
  await appStore.setLoggedIn(true);
}

///end region

/// login api call
Future<LoginResponse> createUser(Map request) async {
  return LoginResponse.fromJson(await (handleResponse(await buildHttpResponse('register', request: request, method: HttpMethod.POST))));
}

///end region

///change password api
Future<BaseResponse> changePassword(Map request) async {
  return BaseResponse.fromJson(await handleResponse(await buildHttpResponse('change-password', request: request, method: HttpMethod.POST)));
}

///end region

/// forgot password
Future<BaseResponse> forgotPassword(Map request) async {
  return BaseResponse.fromJson(await (handleResponse(await buildHttpResponse('forgot-password', request: request, method: HttpMethod.POST))));
}

///end region

/// feedback Api
Future<BaseResponse> addFeedback(Map request) async {
  BaseResponse baseModel = BaseResponse.fromJson(await handleResponse(await buildHttpResponse('add-feedback', request: request, method: HttpMethod.POST)));
  return baseModel;
}

Future<BaseResponse> addToCart(request) async {
  BaseResponse baseModel = BaseResponse.fromJson(await handleResponse(await buildHttpResponse('add-to-cart', request: request, method: HttpMethod.POST)));
  return baseModel;
}

///end region

/// transaction history
Future<TransactionHistoryResponse> getTransactionDetails() async {
  return TransactionHistoryResponse.fromJson(await (handleResponse(await buildHttpResponse('get-transaction-history', method: HttpMethod.GET))));
}

///end region

///dashboard-detail api call
Future<DashboardResponse> getDashboardDetails({String? type, int? page}) async {
  DashboardResponse response;

  response = DashboardResponse.fromJson(await handleResponse(await buildHttpResponse('dashboard-detail', method: HttpMethod.GET)));
  return response;
}

///end region

/// book details api call

Future purchasedBookList() async {
  return await handleResponse(await buildHttpResponse('user-purchase-book'));
}

Future<BaseResponse> removeFromCart(request) async {
  BaseResponse baseResponse = BaseResponse.fromJson(await handleResponse(await buildHttpResponse('remove-from-cart', request: request, method: HttpMethod.POST)));

  return baseResponse;
}

///end region

///view all api call
Future<DashboardResponse> getAllBooks({String? type, int? page}) async {
  return DashboardResponse.fromJson(await (handleResponse(await buildHttpResponse('dashboard-detail?type=$type&page=$page&per_page=$PER_PAGE_ITEM', method: HttpMethod.GET))));
}

///end region

///Category Wise book api call
Future<List<BookDetailResponse>> getCategoryWiseBookDetail({int? page, int? categoryId, int? subCategoryId, List<BookDetailResponse> books = const [], Function(bool)? callback}) async {
  appStore.setLoading(true);
  CategoryWiseBookModel response;
  if (subCategoryId != null) {
    response = CategoryWiseBookModel.fromJson(await (handleResponse(await buildHttpResponse('book-list?page=$page&per_page=$PER_PAGE_ITEM&category_id=$categoryId&subcategory_id=$subCategoryId'))));
  } else {
    response = CategoryWiseBookModel.fromJson(await (handleResponse(await buildHttpResponse('book-list?page=$page&per_page=$PER_PAGE_ITEM&category_id=$categoryId'))));
  }
  if (page == 1) books.clear();
  books.addAll(response.data.validate());

  callback?.call(response.data.validate().length != PER_PAGE_ITEM);

  appStore.setLoading(false);

  return books;
}

Future<CategoryListModel> getAllCategoryList({String? type, int? page}) async {
  return CategoryListModel.fromJson(await (handleResponse(await buildHttpResponse('category-list?type=$type&page=$page&per_page=$PER_PAGE_ITEM', method: HttpMethod.GET))));
}

Future<AllBookDetailsModel> getBookDetails(Map request) async {
  return AllBookDetailsModel.fromJson(await (handleResponse(await buildHttpResponse('book-detail', request: request, method: HttpMethod.POST))));
}

Future<SubCategoryResponse> subCategories(request) async {
  return SubCategoryResponse.fromJson(await (handleResponse(await buildHttpResponse('sub-category-list', request: request, method: HttpMethod.POST))));
}

Future<CartResponse> getCart() async {
  CartResponse cartModel = CartResponse.fromJson(await handleResponse(await buildHttpResponse('user-cart')));
  appStore.setCartCount(cartModel.data!.length.validate());
  return cartModel;
}

///end region

///book list api
Future<CategoryWiseBookModel> bookListApi({int? page, String? searchText, int? authorId}) async {
  CategoryWiseBookModel response;
  if (authorId != null) {
    ///author wise book list api call
    response = CategoryWiseBookModel.fromJson(await (handleResponse(await buildHttpResponse('book-list?page=$page&per_page=$PER_PAGE_ITEM&author_id=$authorId'))));
  } else {
    ///search book list api call
    response = CategoryWiseBookModel.fromJson(await (handleResponse(await buildHttpResponse('book-list?page=$page&per_page=$PER_PAGE_ITEM&search_text=$searchText'))));
  }
  return response;
}

///end region

///author list api call
Future<AuthorListResponse> getAuthorList() async {
  return AuthorListResponse.fromJson(await (handleResponse(await buildHttpResponse('author-list'))));
}

///end Region

///My Wishlist Book
Future<CategoryWiseBookModel> getWishList() async {
  return CategoryWiseBookModel.fromJson(await (handleResponse(await buildHttpResponse('user-wishlist-book'))));
}

///end region

///add remove wishlist  book
Future<BaseResponse> addRemoveWishList(request) async {
  return BaseResponse.fromJson(await handleResponse(await buildHttpResponse('add-remove-wishlist-book', method: HttpMethod.POST, request: request)));
}

///end region
Future<BaseResponse> addReview(request) async {
  return BaseResponse.fromJson(await handleResponse(await buildHttpResponse('add-book-rating', method: HttpMethod.POST, request: request)));
}

Future<BaseResponse> deleteReview(request) async {
  return BaseResponse.fromJson(await handleResponse(await buildHttpResponse('delete-book-rating', method: HttpMethod.POST, request: request)));
}

Future<BaseResponse> updateReview(request) async {
  return BaseResponse.fromJson(await handleResponse(await buildHttpResponse('update-book-rating', method: HttpMethod.POST, request: request)));
}

Future<RatingModel> getAllBookReview(request) async {
  return RatingModel.fromJson(await handleResponse(await buildHttpResponse('book-rating-list', method: HttpMethod.POST, request: request)));
}

///end region

///logout api call
Future logoutApi() async {
  return await handleResponse(await buildHttpResponse('logout', method: HttpMethod.POST));
}

///end region

///logout api call
Future<void> logout(BuildContext context) async {
  if (await isNetworkAvailable()) {
    appStore.setLoading(true);

    logoutApi().then((value) async {
      appStore.setCartCount(0);
      //
    }).catchError((e) {
      log(e.toString());
    });

    await clearPreferences();

    appStore.setLoading(false);
    finish(context);
    DashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
  } else {
    toast(errorInternetNotAvailable);
  }
}

Future updateUser(userDetail, {mSelectedImage, id, userName, name, contactNumber, List<int>? imageFile}) async {
  var request = http.MultipartRequest("POST", Uri.parse('${BASE_URL}save-user-profile'));
  request.fields['id'] = id.toString();
  request.fields['username'] = userName;
  request.fields['name'] = name;
  request.fields['contact_number'] = contactNumber;

  if (imageFile != null) {
    if (isMobile) {
      final file = await http.MultipartFile.fromPath('profile_image', mSelectedImage.path);
      request.files.add(file);
    } else {
      final file = await http.MultipartFile.fromBytes('profile_image', imageFile, filename: "Test");
      request.files.add(file);
    }
  }

  request.headers.addAll(buildHeaderTokens());
  await request.send().then((response) async {
    response.stream.transform(utf8.decoder).listen((value) async {
      LoginResponse loginResponse = LoginResponse.fromJson(jsonDecode(value));

      LoginResponse data = loginResponse;

      appStore.setUserName(data.data!.userName.validate());
      appStore.setName(data.data!.name.validate());
      appStore.setUserEmail(data.data!.email.validate());

      appStore.setUserProfile(data.data!.image.validate());
      appStore.setUserContactNumber(data.data!.contactNumber.validate());
      toast(loginResponse.message.validate());
    });
  }).catchError((error) {
    print(error.toString());
    toast(error);
  });
}

Future<void> clearPreferences() async {
  await appStore.setLoggedIn(false);
  await appStore.setToken('');
  await appStore.setUserEmail('');
  await appStore.setUserId(0);
  await appStore.setUserName('');
  await appStore.setName('');
  await appStore.setUserProfile('');
  await appStore.setUserContactNumber('');
  await appStore.setPaymentMode('');
  await appStore.setDisableNotification(false);
}

///end region

Future getChecksum(request) async {
  return await handleResponse(await buildHttpResponse('generate-check-sum', request: request, method: HttpMethod.POST));
}

Future saveTransaction(Map<String, dynamic> transactionDetails, orderDetails, type, status, totalAmount) async {
  var request = http.MultipartRequest("POST", Uri.parse('${BASE_URL}save-transaction'));
  request.fields['transaction_detail'] = jsonEncode(transactionDetails);
  request.fields['order_detail'] = orderDetails;
  request.fields['type'] = type.toString();
  request.fields['status'] = status.toString();
  request.fields['total_amount'] = totalAmount.toString();

  request.headers.addAll(buildHeaderTokens());
  await request.send().then((res) async {
    if (res.statusCode == 200) {
      toast(language!.transactionSuccessfully);
      LiveStream().emit(CART_DATA_CHANGED, true);
    } else {
      toast(res.statusCode.toString());
    }
  }).catchError((error) {
    throw error;
  });
}

Future<VerifyTransactionResponse> verifyPayment({required String transactionId, required String flutterWaveSecretKey}) async {
  return VerifyTransactionResponse.fromJson(
    await handleResponse(await buildHttpResponse("https://api.flutterwave.com/v3/transactions/$transactionId/verify", header: buildHeaderForFlutterWave(flutterWaveSecretKey))),
  );
}
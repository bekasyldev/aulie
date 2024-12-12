class CommonKeys {
  static String data = 'data';
  static String createdAt = 'created_at';
  static String deletedAt = 'deleted_at';
  static String updatedAt = 'updated_at';
  static String status = 'status';
  static String message = 'message';
  static String pagination = 'pagination';
  static String error = 'error';
  static String bookId = 'book_id';
}

class UserKeys {
  static String activationToken = 'activation_token';
  static String apiToken = 'api_token';
  static String contactNumber = 'contact_number';
  static String createdAt = 'created_at';
  static String email = 'email';
  static String id = 'id';
  static String image = 'image';
  static String name = 'name';
  static String registrationId = 'registration_id';
  static String status = 'status';
  static String deviceId = 'device_id';
  static String emailVerifiedAt = 'email_verified_at';
  static String userType = 'user_type';
  static String userName = 'username';
  static String password = 'password';
  static String oldPassword = "old_password";
  static String newPassword = "new_password";
  static String comment = "comment";
  static String dob = "dob";
}

class DashboardKeys {
  static String categoryBook = "category_book";
  static String categoryBookCount = "category_book_count";
  static String configuration = "configuration";
  static String isPaypalConfiguration = "is_paypal_configuration";
  static String isPaytmConfiguration = "is_paytm_configuration";
  static String popularBook = "popular_book";
  static String popularBookCount = "popular_book_count";
  static String recommendedBook = "recommended_book";
  static String recommendedBookCount = "recommended_book_count";
  static String slider = "slider";
  static String topAuthor = "top_author";
  static String topSearchBook = "top_search_book";
  static String topSearchBookCount = "top_search_book_count";
  static String topSellBook = "top_sell_book";
  static String topSellBookCount = "top_sell_book_count";
  static String categoryId = "category_id";
  static String id = 'id';
  static String key = 'key';
  static String value = 'value';
  static String address = 'address';
  static String authorId = 'author_id';
  static String description = 'description';
  static String designation = 'designation';
  static String education = 'education';
  static String emailId = 'email_id';
  static String mobileNo = 'mobile_no';
  static String authorName = 'author_name';
  static String backCover = 'back_cover';
  static String discount = 'discount';
  static String categoryName = 'category_name';
  static String dateOfPublication = 'date_of_publication';
  static String discountedPrice = 'discounted_price';
  static String edition = 'edition';
  static String filePath = 'file_path';
  static String fileSamplePath = 'file_sample_path';
  static String frontCover = 'front_cover';
  static String isWishlist = 'is_wishlist';
  static String subcategoryName = 'subcategory_name';
  static String topicCover = 'topic_cover';
  static String format = 'format';
  static String keywords = 'keywords';
  static String language = 'language';
  static String price = 'price';
  static String publisher = 'publisher';
  static String title = 'title';
  static String link = 'link';
  static String mobileSliderId = 'mobile_slider_id';
  static String slideImage = 'slide_image';
}

class TransactionKeys {
  static String bookName = "book_name";
  static String bookTitle = "book_title";
  static String discount = "discount";
  static String frontCover = "front_cover";
  static String otherTransactionDetail = "other_transaction_detail";
  static String paymentStatus = "payment_status";
  static String paymentType = "payment_type";
  static String price = "price";
  static String totalAmount = "total_amount";
  static String txnId = "txn_id";
  static String bankName = "BANKNAME";
  static String txnOrderId = "TXN_ORDER_ID";
  static String txnAmount = "TXNAMOUNT";
  static String txnDate = "TXNDATE";
  static String mID = "MID";
  static String txnIds = "TXNID";
  static String paymentMode = "PAYMENTMODE";
  static String currency = "CURRENCY";
  static String bankTxnId = "BANKTXNID";
  static String gatewayName = "GATEWAYNAME";
  static String respMessage = "RESPMSG";
  static String status = "STATUS";
  static String txtPaymentId = "TXN_PAYMENT_ID";
}

class CategoryWiseBook {
  static String maxPrice = "max_price";
}

class AuthorDetailsKey {
  static String address = "address";
  static String authorId = "author_id";
  static String description = "description";
  static String designation = "designation";
  static String education = "education";
  static String emailId = "email_id";
  static String image = "image";
  static String mobileNo = "mobile_no";
  static String name = "name";
  static String status = "status";
}

class AllBookDetailsKey {
  static String authorDetail = "author_detail";
  static String bookDetail = "book_detail";
  static String recommendedBook = "recommended_book";
  static String bookRatingData = "book_rating_data";
  static String authorBookList = 'author_book_list';
  static String userReviewData = "user_review_data";
  static String subCategoryId = "subcategory_id";
}

class BookRatingDataKey {
  static String profileImage = "profile_image";
  static String rating = "rating";
  static String ratingId = "rating_id";
  static String review = "review";
  static String userid = "user_id";
  static String username = "user_name";
  static String totalReview = "total_review";
  static String totalRating = "total_rating";
  static String pageCount = "page_count";
  static String isPurchase = "is_purchase";
}

class PaginationKeys {
  static String currentPage = "currentPage";
  static String from = "from";
  static String nextPage = "next_page";
  static String perPage = "per_page";
  static String previousPage = "previous_page";
  static String to = "to";
  static String totalPages = "totalPages";
  static String totalItems = "total_items";
}

///cart Model key
class CartModelKey {
  static String authorName = 'author_name';
  static String cartMappingId = 'cart_mapping_id';
  static String discount = 'discount';
  static String discountedPrice = 'discounted_price';
  static String frontCover = 'front_cover';
  static String name = 'name';
  static String price = 'price';
  static String title = 'title';
  static String addQty = 'added_qty';
  static String paymentType = 'paymentType';
}

class LibraryBookKey {
  static String id = 'id';
  static String taskId = 'task_id';
  static String bookName = 'book_name';
  static String frontCover = 'front_cover';
  static String fileType = 'file_type';
  static String filePath = 'file_Path';
  static String webBookPath = 'web_book_path';
  static String authorName = 'author_name';
  static String userId = 'user_id';
}

class CheckSumKey {
  static String orderData = 'order_data';
  static String checkSumData = 'checksum_data';
}

import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

///add remove wishlist
Future<void> addRemoveWishListApi(int id, int isWishList) async {
  toast(language!.processing);
  Map request = {"book_id": id, "is_wishlist": isWishList};
  await addRemoveWishList(request).then((res) {
    LiveStream().emit(WISH_LIST_ITEM_CHANGED);

    toast(res.message!);
  }).catchError((error) {
    toast(error.toString());
  });
}

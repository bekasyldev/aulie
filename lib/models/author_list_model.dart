import '../utils/model_keys.dart';
import 'author_model.dart';

class AuthorListResponse {
  List<AuthorResponse>? authorListData;

  AuthorListResponse({this.authorListData});

  factory AuthorListResponse.fromJson(Map<String, dynamic> json) {
    return AuthorListResponse(
      authorListData: json[CommonKeys.data] != null ? (json[CommonKeys.data] as List).map((i) => AuthorResponse.fromJson(i)).toList() : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.authorListData != null) {
      data[CommonKeys.data] = this.authorListData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

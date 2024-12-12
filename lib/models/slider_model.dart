import 'package:granth_flutter/utils/model_keys.dart';

class SliderResponse {
  String? link;
  int? mobileSliderId;
  String? slideImage;
  String? title;

  SliderResponse({this.link, this.mobileSliderId, this.slideImage, this.title});

  factory SliderResponse.fromJson(Map<String, dynamic> json) {
    return SliderResponse(
      link: json[DashboardKeys.link] != null ? json[DashboardKeys.link] : null,
      mobileSliderId: json[DashboardKeys.mobileSliderId],
      slideImage: json[DashboardKeys.slideImage],
      title: json[DashboardKeys.title] != null ? json[DashboardKeys.title] : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[DashboardKeys.mobileSliderId] = this.mobileSliderId;
    data[DashboardKeys.slideImage] = this.slideImage;
    if (this.link != null) {
      data[DashboardKeys.link] = this.link;
    }
    if (this.title != null) {
      data[DashboardKeys.title] = this.title;
    }
    return data;
  }
}

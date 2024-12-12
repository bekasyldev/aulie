import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/cache_image_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/screen/auth/edit_profile_screen.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class SettingTopComponent extends StatefulWidget {
  static String tag = '/SettingTopComponent';

  @override
  SettingTopComponentState createState() => SettingTopComponentState();
}

class SettingTopComponentState extends State<SettingTopComponent> {
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
    return Observer(
      builder: (context) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${language!.hey},", style: boldTextStyle(size: 24)),
                    8.height,
                    Text(appStore.name.validate(), maxLines: 2, style: boldTextStyle(size: 24)),
                  ],
                ).expand(),
                8.width,
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    appStore.userProfile.isNotEmpty
                        ? Observer(builder: (context) {
                            return CachedImageWidget(
                              url: appStore.userProfile.validate(),
                              height: isWeb ? 70 : 80,
                              width: isWeb ? 70 : 80,
                              fit: BoxFit.cover,
                            ).cornerRadiusWithClipRRect(40);
                          })
                        : Image.asset(place_holder_img, width: isWeb ? 70 : 80, height: isWeb ? 70 : 80, fit: BoxFit.cover).cornerRadiusWithClipRRect(40),
                    Positioned(
                      bottom: 6,
                      right: -4,
                      child: CircleAvatar(
                        child: Icon(Icons.edit, color: whiteColor, size: 14),
                        radius: 14,
                        backgroundColor: defaultPrimaryColor,
                      ).onTap(() {
                        EditProfileScreen().launch(context);
                      }),
                    )
                  ],
                )
              ],
            ).paddingSymmetric(horizontal: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${language!.loggedIn}" + " " + appStore.userEmail.validate(),
                  maxLines: 2,
                  style: secondaryTextStyle(),
                  overflow: TextOverflow.ellipsis,
                ).expand(),
                8.width,
                Container(width: 100, child: Divider(color: defaultPrimaryColor))
              ],
            ).paddingSymmetric(horizontal: 16),
          ],
        );
      },
    );
  }
}

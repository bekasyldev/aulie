import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/cache_image_widget.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/screen/auth/edit_profile_screen.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class WebSettingTopComponent extends StatefulWidget {
  static String tag = '/SettingTopComponent';

  @override
  WebSettingTopComponentState createState() => WebSettingTopComponentState();
}

class WebSettingTopComponentState extends State<WebSettingTopComponent> {
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
        return Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                appStore.userProfile.isNotEmpty
                    ? Observer(builder: (context) {
                        return CachedImageWidget(
                          url: appStore.userProfile.validate(),
                          height: 65,
                          width: 65,
                          fit: BoxFit.cover,
                        ).cornerRadiusWithClipRRect(40);
                      })
                    : Image.asset(place_holder_img, width: 65, height: 65, fit: BoxFit.cover).cornerRadiusWithClipRRect(40),
                Positioned(
                  bottom: 6,
                  right: -4,
                  child: CircleAvatar(
                    child: Icon(Icons.edit, color: Colors.white, size: 14),
                    radius: 12,
                    backgroundColor: defaultPrimaryColor,
                  ).onTap(() {
                    EditProfileScreen().launch(context);
                  }),
                )
              ],
            ),
            20.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appStore.name.validate(), maxLines: 2, style: boldTextStyle(size: 18), overflow: TextOverflow.ellipsis),
                6.height,
                Text(appStore.userEmail.validate(), maxLines: 2, style: secondaryTextStyle(), overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        ).fit();
      },
    );
  }
}

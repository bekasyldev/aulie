import 'package:flutter/material.dart';
import 'package:granth_flutter/screen/auth/component/mobile_login_component.dart';
import 'package:granth_flutter/screen/auth/web_screen/sign_in_screen_web.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInScreen extends StatefulWidget {
  static String tag = '/SignInScreen';

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(transparentColor, statusBarBrightness: Brightness.dark, statusBarIconBrightness: Brightness.dark);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Responsive(
        mobile: MobileLoginComponent(),
        web: WebLoginScreen(),
        tablet: MobileLoginComponent(),
      ),
    );
  }
}

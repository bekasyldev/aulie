import 'package:flutter/material.dart';
import 'package:granth_flutter/screen/auth/component/mobile_sign_up_component.dart';
import 'package:granth_flutter/screen/auth/web_screen/sign_up_screen_web.dart';
import 'package:nb_utils/nb_utils.dart';

class SignupScreen extends StatefulWidget {
  static String tag = '/SignupScreen';

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
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
        mobile: MobileSignUpComponent(),
        web: WebSignupScreen(),
        tablet: MobileSignUpComponent(),
      ),
    );
  }
}

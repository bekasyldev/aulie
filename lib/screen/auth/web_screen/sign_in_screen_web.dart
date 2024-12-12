import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/auth/component/signin_bottom_widget.dart';
import 'package:granth_flutter/screen/auth/component/signin_top_component.dart';
import 'package:granth_flutter/screen/auth/forgot_password_screen.dart';
import 'package:granth_flutter/screen/auth/sign_up_screen.dart';
import 'package:granth_flutter/screen/dashboard/dashboard_screen.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/constants.dart';
import 'package:granth_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class WebLoginScreen extends StatefulWidget {
  @override
  _WebLoginScreenState createState() => _WebLoginScreenState();
}

class _WebLoginScreenState extends State<WebLoginScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode? emailFocusNode = FocusNode();
  FocusNode? passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  ///login api call
  Future<void> loginApi(BuildContext context) async {
    if (appStore.isLoading) return;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);

      Map request = {
        UserKeys.deviceId: "",
        UserKeys.email: emailController.text.trim(),
        UserKeys.password: passwordController.text.trim(),
        UserKeys.registrationId: getStringAsync(PLAYER_ID),
      };

      appStore.setLoading(true);

      await login(request).then((res) async {
        if (res.data != null) await saveUserData(res.data!);
        DashboardScreen().launch(context, isNewTask: true, pageRouteAnimation: PageRouteAnimation.Fade);
        toast(language!.loginSuccessfully);
      }).catchError((e) {
        appStore.setLoading(false);
        toast(e.toString());
      });
      appStore.setLoading(false);
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: context.height(),
            width: context.width(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: SizedBox(
                    width: 600,
                    child: Card(
                      color: appStore.isDarkMode ? scaffoldDarkColor : Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(22.0),
                        child: Column(
                          children: [
                            SignInTopComponent(),
                            Column(
                              children: [
                                Text(language!.login, style: boldTextStyle(size: 28)).center(),
                                8.height,
                                Text(language!.signInToContinue, style: secondaryTextStyle()),
                                32.height,
                                AppTextField(
                                  controller: emailController,
                                  autoFocus: false,
                                  textFieldType: TextFieldType.EMAIL,
                                  focus: emailFocusNode,
                                  nextFocus: passwordFocusNode,
                                  decoration: inputDecoration(context, hintText: language!.email),
                                ),
                                16.height,
                                AppTextField(
                                  controller: passwordController,
                                  autoFocus: false,
                                  textFieldType: TextFieldType.PASSWORD,
                                  focus: passwordFocusNode,
                                  decoration: inputDecoration(context, hintText: language!.password),
                                  onFieldSubmitted: (value) {
                                    loginApi(context);
                                  },
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                    onPressed: () {
                                      ForgotPasswordScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                                    },
                                    child: Text(language!.lblForgotPassword, style: boldTextStyle(color: defaultPrimaryColor, size: 14)),
                                  ),
                                ),
                                24.height,
                                AppButton(
                                  width: context.width(),
                                  text: language!.login,
                                  textStyle: boldTextStyle(color: Colors.white),
                                  color: defaultPrimaryColor,
                                  enableScaleAnimation: false,
                                  onTap: () async {
                                    loginApi(context);
                                  },
                                ),
                                32.height,
                                SignInBottomWidget(
                                  title: language!.donTHaveAnAccount,
                                  subTitle: language!.register,
                                  onTap: () {
                                    SignupScreen().launch(context, pageRouteAnimation: PageRouteAnimation.Slide);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).fit(),
                ),
                Observer(
                  builder: (context) {
                    return AppLoaderWidget().visible(appStore.isLoading).center();
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

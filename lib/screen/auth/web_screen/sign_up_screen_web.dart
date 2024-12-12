import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/component/app_loader_widget.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/auth/component/signin_bottom_widget.dart';
import 'package:granth_flutter/screen/auth/component/signin_top_component.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:granth_flutter/utils/model_keys.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class WebSignupScreen extends StatefulWidget {
  @override
  _WebSignupScreenState createState() => _WebSignupScreenState();
}

class _WebSignupScreenState extends State<WebSignupScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode? nameFocusNode = FocusNode();
  FocusNode? userNameFocusNode = FocusNode();
  FocusNode? emailFocusNode = FocusNode();
  FocusNode? mobileNumberFocusNode = FocusNode();
  FocusNode? passwordFocusNode = FocusNode();
  FocusNode? confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  ///createUser api call
  Future<void> createUserApi(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      hideKeyboard(context);

      Map request = {
        UserKeys.email: emailController.text.trim(),
        UserKeys.name: nameController.text.trim(),
        UserKeys.userName: usernameController.text.trim(),
        UserKeys.password: passwordController.text.trim(),
      };

      appStore.setLoading(true);

      await createUser(request).then((res) async {
        if (res.data != null) await saveUserData(res.data!);
        finish(context);
        toast(res.message);
      }).catchError((e) {
        toast(e.toString());
        appStore.setLoading(false);
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
    return Row(
      children: [
        SizedBox(
          height: context.height(),
          width: context.width(),
          child: Scaffold(
            backgroundColor: defaultPrimaryColor.withOpacity(0.7),
            appBar: AppBar(elevation: 0, backgroundColor: defaultPrimaryColor.withOpacity(0.1), iconTheme: IconThemeData(color: Colors.white)),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(app_logo, height: 65, width: 65).cornerRadiusWithClipRRect(defaultRadius),
                    8.width,
                    Text('Granth', style: boldTextStyle(size: 26, color: Colors.white)),
                  ],
                ),
                30.height,
                Lottie.asset(walk_through_2, height: context.height() * 0.4, width: context.width() * 0.4),
                10.height,
                Text('Version $appVersion', style: secondaryTextStyle(color: Colors.white)),
              ],
            ),
          ),
        ).expand(flex: 3),
        SingleChildScrollView(
          child: SizedBox(
            height: context.height(),
            width: context.width(),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    width: 500,
                    child: Column(
                      children: [
                        30.height,
                        SignInTopComponent(),
                        Column(
                          children: [
                            Text(language!.joinNow, style: boldTextStyle(size: 28)),
                            8.height,
                            Text(language!.pleaseEnterInfoTo, style: secondaryTextStyle()),
                            32.height,
                            AppTextField(
                              controller: nameController,
                              decoration: inputDecoration(context, hintText: language!.name),
                              textFieldType: TextFieldType.NAME,
                              focus: nameFocusNode,
                              nextFocus: userNameFocusNode,
                            ),
                            16.height,
                            AppTextField(
                              controller: usernameController,
                              decoration: inputDecoration(context, hintText: language!.userName),
                              textFieldType: TextFieldType.USERNAME,
                              focus: userNameFocusNode,
                              nextFocus: emailFocusNode,
                            ),
                            16.height,
                            AppTextField(
                              controller: emailController,
                              decoration: inputDecoration(context, hintText: language!.email),
                              textFieldType: TextFieldType.EMAIL,
                              focus: emailFocusNode,
                              nextFocus: mobileNumberFocusNode,
                            ),
                            16.height,
                            AppTextField(
                              textStyle: primaryTextStyle(),
                              textFieldType: TextFieldType.PHONE,
                              focus: mobileNumberFocusNode,
                              nextFocus: passwordFocusNode,
                              controller: mobileNumberController,
                              decoration: inputDecoration(context, hintText: language!.contactNumber),
                            ),
                            16.height,
                            AppTextField(
                              controller: passwordController,
                              textFieldType: TextFieldType.PASSWORD,
                              focus: passwordFocusNode,
                              nextFocus: confirmPasswordFocusNode,
                              decoration: inputDecoration(context, hintText: language!.password),
                            ),
                            16.height,
                            AppTextField(
                              textFieldType: TextFieldType.PASSWORD,
                              focus: confirmPasswordFocusNode,
                              controller: confirmPasswordController,
                              decoration: inputDecoration(context, hintText: language!.confirmPassword),
                              onFieldSubmitted: (value) {
                                createUserApi(context);
                              },
                              validator: (value) {
                                if (value!.trim().isEmpty) return language!.confirmPasswordRequired;
                                if (value.trim().length < passwordLengthGlobal) return language!.passwordDoesnTMatch;
                                return passwordController.text == value.trim() ? null : language!.passwordDoesnTMatch;
                              },
                            ),
                            16.height,
                            AppButton(
                              width: context.width(),
                              text: language!.register,
                              textStyle: boldTextStyle(color: Colors.white),
                              color: defaultPrimaryColor,
                              onTap: () {
                                createUserApi(context);
                              },
                            ),
                            32.height,
                            SignInBottomWidget(
                              title: language!.alreadyHaveAnAccount,
                              subTitle: language!.login,
                              onTap: () {
                                finish(context);
                              },
                            ),
                          ],
                        ),
                      ],
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
        ).expand(flex: 7),
      ],
    );
  }
}

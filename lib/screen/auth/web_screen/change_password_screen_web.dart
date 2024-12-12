import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/screen/dashboard/dashboard_screen.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:granth_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class WebChangePasswordScreen extends StatefulWidget {
  @override
  _WebChangePasswordScreenState createState() => _WebChangePasswordScreenState();
}

class _WebChangePasswordScreenState extends State<WebChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode oldPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  ///change password api call
  Future<void> changePasswordApi(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      hideKeyboard(context);

      Map request = {
        UserKeys.email: appStore.userEmail,
        UserKeys.oldPassword: oldPasswordController.text.trim(),
        UserKeys.newPassword: confirmPasswordController.text.trim(),
      };

      appStore.setLoading(true);

      await changePassword(request).then((res) async {
        if (res.status!) {
          oldPasswordController.text = '';
          newPasswordController.text = '';
          confirmPasswordController.text = '';
          DashboardScreen().launch(context);
          toast(res.message.toString());
        } else {
          toast(parseHtmlString(res.message));
        }
      }).catchError((e) {
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
        appBar: appBarWidget('', showBack: false, elevation: 0, color: context.dividerColor.withOpacity(0.1)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              WebBreadCrumbWidget(context, title: language!.changePassword, subTitle1: 'Home', subTitle2: language!.changePassword),
              Container(
                width: 500,
                decoration: boxDecorationDefault(boxShadow: [BoxShadow(color: Colors.transparent)], color: appStore.isDarkMode ? scaffoldDarkColor : Colors.white),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Image.asset(forgot_password, height: context.height() * 0.25, width: context.width()),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.height,
                            Text(language!.createANewPassword, style: boldTextStyle(size: 20)),
                            8.height,
                            Text(language!.youNewPasswordMust, style: secondaryTextStyle()),
                            16.height,
                            AppTextField(
                              controller: oldPasswordController,
                              focus: oldPasswordFocusNode,
                              nextFocus: newPasswordFocusNode,
                              textFieldType: TextFieldType.PASSWORD,
                              decoration: inputDecoration(context, hintText: language!.oldPassword),
                            ),
                            16.height,
                            AppTextField(
                              controller: newPasswordController,
                              textFieldType: TextFieldType.PASSWORD,
                              focus: newPasswordFocusNode,
                              nextFocus: confirmPasswordFocusNode,
                              decoration: inputDecoration(context, hintText: language!.newPassword),
                            ),
                            16.height,
                            AppTextField(
                              controller: confirmPasswordController,
                              textFieldType: TextFieldType.PASSWORD,
                              focus: confirmPasswordFocusNode,
                              decoration: inputDecoration(context, hintText: language!.confirmPassword),
                              validator: (val) {
                                if (val!.isEmpty) return language!.thisFieldIsRequired;
                                if (val != newPasswordController.text) return language!.passwordMustBeSame;
                                return null;
                              },
                              onFieldSubmitted: (value) {
                                changePasswordApi(context);
                              },
                            ),
                            50.height,
                            AppButton(
                              color: defaultPrimaryColor,
                              width: context.width(),
                              textStyle: boldTextStyle(color: Colors.white),
                              text: language!.submit,
                              onTap: () {
                                changePasswordApi(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ).paddingBottom(16),
            ],
          ),
        ),
      );
    });
  }
}

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class WebEditProfileScreen extends StatefulWidget {
  final double? width;
  final Uint8List? imageWebFile;

  WebEditProfileScreen({this.width, this.imageWebFile});

  @override
  _WebEditProfileScreenState createState() => _WebEditProfileScreenState();
}

class _WebEditProfileScreenState extends State<WebEditProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  FocusNode? nameFocusNode = FocusNode();
  FocusNode? userNameFocusNode = FocusNode();
  FocusNode? emailFocusNode = FocusNode();
  FocusNode? mobileNumberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    nameController.text = appStore.name.validate();
    usernameController.text = appStore.userName.validate();
    emailController.text = appStore.userEmail.validate();
    mobileNumberController.text = appStore.userContactNumber.validate();
  }

  ///save profile api call
  Future<void> saveProfile(BuildContext context) async {
    hideKeyboard(context);
    appStore.setLoading(true);

    Map request = {
      UserKeys.id: appStore.userId,
      UserKeys.userName: usernameController.text.trim(),
      UserKeys.name: nameController.text.trim(),
      UserKeys.email: emailController.text.trim(),
      UserKeys.dob: "",
      UserKeys.contactNumber: mobileNumberController.text.trim(),
    };

    List<int> list = widget.imageWebFile!.cast();
    await updateUser(request, imageFile: list, id: appStore.userId, name: nameController.text.trim(), userName: usernameController.text.trim(), contactNumber: mobileNumberController.text.trim()).then((result) {
      appStore.setLoading(false);
      finish(context);
    }).catchError((error) {
      toast(error.toString());
      appStore.setLoading(false);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget buildSizeBoxWidget({required Widget child}) {
    return SizedBox(width: widget.width ?? context.width() / 3 - 20, child: child);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          width: context.width(),
          margin: EdgeInsets.only(top: context.height() * .25),
          padding: EdgeInsets.only(top: defaultRadius, left: defaultRadius),
          decoration: boxDecorationWithRoundedCorners(
            backgroundColor: appBarBackgroundColorGlobal,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(defaultRadius), topRight: Radius.circular(defaultRadius)),
          ),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 7,
                runSpacing: defaultRadius,
                children: [
                  buildSizeBoxWidget(
                    child: AppTextField(
                      decoration: inputDecoration(context, hintText: language!.name),
                      textFieldType: TextFieldType.NAME,
                      controller: nameController,
                      focus: nameFocusNode,
                      nextFocus: userNameFocusNode,
                    ),
                  ),
                  16.height,
                  buildSizeBoxWidget(
                    child: AppTextField(
                      textFieldType: TextFieldType.USERNAME,
                      focus: userNameFocusNode,
                      controller: usernameController,
                      nextFocus: emailFocusNode,
                      decoration: inputDecoration(context, hintText: language!.userName),
                    ),
                  ),
                  16.height,
                  buildSizeBoxWidget(
                    child: AppTextField(
                      textFieldType: TextFieldType.EMAIL,
                      focus: emailFocusNode,
                      nextFocus: mobileNumberFocusNode,
                      controller: emailController,
                      enabled: false,
                      decoration: inputDecoration(context, hintText: language!.email),
                    ),
                  ),
                  16.height,
                  buildSizeBoxWidget(
                    child: AppTextField(
                      textFieldType: TextFieldType.PHONE,
                      focus: mobileNumberFocusNode,
                      controller: mobileNumberController,
                      decoration: inputDecoration(context, hintText: language!.contactNumber),
                      onFieldSubmitted: (value) {
                        saveProfile(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 26,
          right: 16,
          child: AppButton(
            text: language!.updateProfile,
            width: 200,
            textStyle: boldTextStyle(color: Colors.white),
            color: defaultPrimaryColor,
            enableScaleAnimation: false,
            onTap: () {
              saveProfile(context);
            },
          ).paddingSymmetric(horizontal: 10).cornerRadiusWithClipRRect(defaultRadius),
        ),
      ],
    );
  }
}

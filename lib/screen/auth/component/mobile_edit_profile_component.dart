import 'dart:io';

import 'package:flutter/material.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class MobileEditProfileComponent extends StatefulWidget {
  final File? imageFile;

  MobileEditProfileComponent({this.imageFile});

  @override
  _MobileEditProfileComponentState createState() => _MobileEditProfileComponentState();
}

class _MobileEditProfileComponentState extends State<MobileEditProfileComponent> {
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

    await updateUser(request, mSelectedImage: widget.imageFile, id: appStore.userId, name: nameController.text.trim(), userName: usernameController.text.trim(), contactNumber: mobileNumberController.text.trim()).then((result) {
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          margin: EdgeInsets.only(top: context.height() * .25),
          decoration: boxDecorationWithRoundedCorners(
            backgroundColor: appBarBackgroundColorGlobal,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(defaultRadius), topRight: Radius.circular(defaultRadius)),
          ),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppTextField(
                    decoration: inputDecoration(context, hintText: language!.name),
                    textFieldType: TextFieldType.NAME,
                    controller: nameController,
                    focus: nameFocusNode,
                    nextFocus: userNameFocusNode,
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.USERNAME,
                    focus: userNameFocusNode,
                    controller: usernameController,
                    nextFocus: emailFocusNode,
                    decoration: inputDecoration(context, hintText: language!.userName),
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.EMAIL,
                    focus: emailFocusNode,
                    nextFocus: mobileNumberFocusNode,
                    controller: emailController,
                    enabled: false,
                    decoration: inputDecoration(context, hintText: language!.email),
                  ),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.PHONE,
                    focus: mobileNumberFocusNode,
                    controller: mobileNumberController,
                    decoration: inputDecoration(context, hintText: language!.contactNumber),
                    onFieldSubmitted: (value) {
                      saveProfile(context);
                    },
                  ),
                  16.height,
                ],
              ).paddingAll(16),
            ),
          ),
        ),
        Positioned(
          bottom: 26,
          left: 16,
          right: 16,
          child: AppButton(
            width: context.width(),
            text: language!.updateProfile,
            textStyle: boldTextStyle(color: Colors.white),
            color: defaultPrimaryColor,
            enableScaleAnimation: false,
            onTap: () {
              saveProfile(context);
            },
          ).cornerRadiusWithClipRRect(defaultRadius),
        ),
      ],
    );
  }
}

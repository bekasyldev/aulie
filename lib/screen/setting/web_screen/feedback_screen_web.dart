import 'package:flutter/material.dart';
import 'package:granth_flutter/configs.dart';
import 'package:granth_flutter/main.dart';
import 'package:granth_flutter/network/rest_apis.dart';
import 'package:granth_flutter/utils/common.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:granth_flutter/utils/model_keys.dart';
import 'package:nb_utils/nb_utils.dart';

class WebFeedbackScreen extends StatefulWidget {
  @override
  _WebFeedbackScreenState createState() => _WebFeedbackScreenState();
}

class _WebFeedbackScreenState extends State<WebFeedbackScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  /// feedback Api
  Future<void> addFeedbackApi(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      hideKeyboard(context);

      Map request = {
        UserKeys.name: nameController.text.trim(),
        UserKeys.email: emailController.text.trim(),
        UserKeys.comment: messageController.text.trim(),
      };
      appStore.setLoading(true);

      await addFeedback(request).then((res) async {
        if (res.status!) {
          toast(res.message.toString());
          nameController.text = '';
          emailController.text = '';
          messageController.text = '';
          finish(context);
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(feedback_img, height: context.height() * 0.30, width: context.width()),
              16.height,
              AppTextField(
                controller: nameController,
                textFieldType: TextFieldType.NAME,
                decoration: inputDecoration(context, hintText: language!.name),
              ),
              16.height,
              AppTextField(
                controller: emailController,
                textFieldType: TextFieldType.EMAIL,
                decoration: inputDecoration(context, hintText: language!.email),
              ),
              16.height,
              AppTextField(
                controller: messageController,
                textFieldType: TextFieldType.MULTILINE,
                decoration: inputDecoration(context, hintText: language!.message),
                onFieldSubmitted: (value) {
                  addFeedbackApi(context);
                },
              ),
              50.height,
              AppButton(
                color: defaultPrimaryColor,
                width: context.width(),
                textStyle: boldTextStyle(color: Colors.white),
                text: language!.submit,
                onTap: () {
                  addFeedbackApi(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

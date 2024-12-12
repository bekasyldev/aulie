import 'package:flutter/material.dart';
import 'package:granth_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class SignInTopComponent extends StatelessWidget {
  const SignInTopComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(login_book1, height: 180, width: 100, fit: BoxFit.fill).cornerRadiusWithClipRRect(60),
          Positioned(
            left: -22,
            top: 42,
            child: Image.asset(login_book2, height: 80, width: 50, fit: BoxFit.cover).cornerRadiusWithClipRRect(80),
          ),
          Positioned(
            bottom: 24,
            right: -62,
            child: Image.asset(login_book3, height: 160, width: 100, fit: BoxFit.cover).cornerRadiusWithClipRRect(80),
          ),
        ],
      ),
    );
  }
}

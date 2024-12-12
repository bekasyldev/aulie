// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/screen/dashboard/fragment/mobile_cart_fragment.dart';
import 'package:granth_flutter/screen/dashboard/fragment/web_fragment/cart_fragment_web.dart';
import 'package:nb_utils/nb_utils.dart';

class CartFragment extends StatefulWidget {
  final bool? isShowBack;

  CartFragment({this.isShowBack});

  @override
  CartFragmentState createState() => CartFragmentState();
}

class CartFragmentState extends State<CartFragment> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: MobileCartFragment(isShowBack: widget.isShowBack),
        web: WebCartFragmentScreen(isShowBack: widget.isShowBack),
        tablet: MobileCartFragment(isShowBack: widget.isShowBack),
      ),
    );
  }
}

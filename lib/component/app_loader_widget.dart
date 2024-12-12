import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.asset('images/lottie/app_loader.json', height: 220, width: 220, fit: BoxFit.cover);
  }
}

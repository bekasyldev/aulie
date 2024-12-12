import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:granth_flutter/main.dart';
import 'package:nb_utils/nb_utils.dart';

import 'colors.dart';

BottomNavigationBarItem bottomNavigationBarItem(BuildContext context, {String? inActiveIconData, String? activeIconData, bool? isCart = false, bool isIconHide = false}) {
  return BottomNavigationBarItem(
    backgroundColor: secondaryPrimaryColor,
    icon: isCart!
        ? Observer(builder: (context) {
            return Badge(
              backgroundColor: Colors.red,
              isLabelVisible: appStore.cartCount > 0,
              label: Text(appStore.cartCount.toString(), style: primaryTextStyle(color: Colors.white, size: 12)),
              child: Image.asset(
                inActiveIconData!,
                color: appStore.isDarkMode ? whiteColor : grey,
                height: isIconHide ? 0 : 25,
                width: isIconHide ? 0 : 25,
              ),
            );
          })
        : Image.asset(
            inActiveIconData!,
            color: appStore.isDarkMode ? whiteColor : grey,
            height: isIconHide ? 0 : 25,
            width: isIconHide ? 0 : 25,
          ),
    activeIcon: isCart
        ? Badge(
            backgroundColor: Colors.red,
            isLabelVisible: appStore.cartCount > 0,
            label: Text(appStore.cartCount.toString(), style: primaryTextStyle(color: Colors.white, size: 12)),
            child: Image.asset(
              activeIconData!,
              color: appStore.isDarkMode ? whiteColor : blackColor,
              height: isIconHide ? 0 : 26,
              width: isIconHide ? 0 : 26,
            ),
          )
        : Image.asset(
            activeIconData!,
            color: appStore.isDarkMode ? whiteColor : blackColor,
            height: isIconHide ? 0 : 26,
            width: isIconHide ? 0 : 26,
          ),
    label: '',
  );
}

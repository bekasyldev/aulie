import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:granth_flutter/utils/colors.dart';
import 'package:granth_flutter/configs.dart';
import 'package:nb_utils/nb_utils.dart';

class AppThemeData {
  //
  AppThemeData._();

  static final ThemeData lightTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: createMaterialColor(defaultPrimaryColor),
    primaryColor: defaultPrimaryColor,
    scaffoldBackgroundColor: secondaryPrimaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: secondaryPrimaryColor),
    iconTheme: IconThemeData(color: Colors.black),
    fontFamily: GoogleFonts.roboto().fontFamily,
    dialogBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    dividerColor: grey.withOpacity(0.5),
    cardColor: white,
    canvasColor: defaultPrimaryColor,
    textTheme: GoogleFonts.robotoTextTheme(),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: defaultPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: secondaryPrimaryColor,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black, size: 24),
      actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
      titleTextStyle: boldTextStyle(size: 20),
    ),
    scrollbarTheme: ScrollbarThemeData(thumbColor: MaterialStateProperty.all(Colors.black), radius: Radius.circular(defaultRadius)),
    dialogTheme: DialogTheme(
      backgroundColor: cardColor,
      contentTextStyle: primaryTextStyle(color: Colors.red),
      titleTextStyle: boldTextStyle(),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(defaultPrimaryColor),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(defaultPrimaryColor),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: createMaterialColor(scaffoldColorDark),
    primaryColor: scaffoldColorDark,
    scaffoldBackgroundColor: scaffoldColorDark,
    fontFamily: GoogleFonts.roboto().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: scaffoldColorDark),
    iconTheme: IconThemeData(color: Colors.white),
    dialogBackgroundColor: scaffoldColorDark,
    unselectedWidgetColor: Colors.white,
    dividerColor: Colors.white12,
    cardColor: scaffoldSecondaryDark,
    canvasColor: scaffoldColorDark,
    textTheme: GoogleFonts.robotoTextTheme(),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: defaultPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.0,
      color: Color(0xFF090909),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white, size: 24),
      actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
      titleTextStyle: boldTextStyle(size: 20),
    ),
    scrollbarTheme: ScrollbarThemeData(thumbColor: MaterialStateProperty.all(scaffoldColorDark), radius: Radius.circular(defaultRadius)),
    dialogTheme: DialogTheme(
      backgroundColor: cardColor,
      contentTextStyle: primaryTextStyle(color: Colors.red),
      titleTextStyle: boldTextStyle(),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(scaffoldSecondaryDark),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(scaffoldSecondaryDark),
      overlayColor: MaterialStateProperty.all(Color(0xFF5D5F6E)),
    ),
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );
}

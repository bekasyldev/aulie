import 'package:flutter/material.dart';
import 'package:granth_flutter/screen/setting/component/mobile_language_component.dart';
import 'package:granth_flutter/screen/setting/web_screen/language_screen_web.dart';
import 'package:nb_utils/nb_utils.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  LanguagesScreenState createState() => LanguagesScreenState();
}

class LanguagesScreenState extends State<LanguagesScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: MobileLanguageComponent(),
        web: WebLanguageScreen(),
        tablet: MobileLanguageComponent(),
      ),
    );
  }
}

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(
      id: 1,
      name: 'English',
      languageCode: 'en',
      fullLanguageCode: 'en-US',
      flag: 'images/flag/ic_us.png'
    ),
    LanguageDataModel(
      id: 2,
      name: 'Русский',
      languageCode: 'ru',
      fullLanguageCode: 'ru-RU',
      flag: 'images/flag/ic_ru.png'
    ),
    LanguageDataModel(
      id: 3,
      name: 'Қазақша',
      languageCode: 'kk',
      fullLanguageCode: 'kk-KZ',
      flag: 'images/flag/ic_kz.png'
    ),
  ];
}

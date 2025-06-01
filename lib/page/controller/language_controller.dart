import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BahasaController extends GetxController {
  static var locale = const Locale('id', 'ID').obs;

  void changeLanguage(String languageCode) {
    Locale newLocale;
    switch (languageCode) {
      case 'en':
        newLocale = const Locale('en', 'US');
        break;
      case 'es':
        newLocale = const Locale('es', 'ES');
        break;
      default:
        newLocale = const Locale('id', 'ID');
    }
    locale.value = newLocale;
    Get.updateLocale(newLocale);
  }
}
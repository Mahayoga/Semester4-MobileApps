import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LanguageController extends GetxController {
  void changeLanguage(String langCode) {
    Locale locale = Locale(langCode);
    Get.updateLocale(locale);
  }
}

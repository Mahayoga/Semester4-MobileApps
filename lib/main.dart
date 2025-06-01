import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'page/landing/landing.dart';
import 'page/login/login.dart';
import 'page/login/lupa_password.dart';
import 'page/login/verification_screen.dart';
import 'page/login/new_password_screen.dart';
import 'page/daftar/daftar.dart';
import 'page/daftar/akun_terverifikasi.dart';
import 'page/daftar/buat_username.dart';
import 'page/daftar/verifikasi_email.dart';
import 'page/dashboard/dashboard.dart';
import 'page/profil/profil.dart';
import 'page/controller/language_controller.dart';
import 'page/lang/translations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: BahasaController.locale.value,
      fallbackLocale: const Locale('id', 'ID'),
      home: const MainNavigation(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LandingPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/daftar', page: () => DaftarPage()),
        GetPage(name: '/buat-username', page: () => buat_usernamePage()),
        GetPage(name: '/akun-terverifikasi', page: () => akun_terverifikasiPage()),
        GetPage(name: '/verifikasi-email', page: () => VerifikasiEmailPage()),
        GetPage(name: '/forgot-password', page: () => ForgotPasswordScreen()),
        GetPage(name: '/verification', page: () => VerificationScreen()),
        GetPage(name: '/new-password', page: () => NewPasswordScreen()),
        GetPage(name: '/dashboard', page: () => MainNavigation()),
        GetPage(name: '/ProfilePage', page: () => ProfilePagen()),
      ],
    ));
  }
}
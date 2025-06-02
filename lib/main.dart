import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = await prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(initialRoute: isLoggedIn ? '/dasboard' : '/'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: BahasaController.locale.value,
      fallbackLocale: const Locale('id', 'ID'),
      home: LandingPage(),
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: '/', page: () => LandingPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/daftar', page: () => DaftarPage()),
        GetPage(name: '/buat-username', page: () => buat_usernamePage(email: '')),
        GetPage(name: '/akun-terverifikasi', page: () => akun_terverifikasiPage(email: '')),
        GetPage(name: '/verifikasi-email', page: () => VerifikasiEmailPage(email: '')),
        GetPage(name: '/forgot-password', page: () => ForgotPasswordScreen()),
        GetPage(name: '/verification', page: () => VerificationScreen(email: '')),
        GetPage(name: '/new-password', page: () => NewPasswordScreen()),
        GetPage(name: '/dashboard', page: () => MainNavigation()),
        GetPage(name: '/ProfilePage', page: () => ProfilePagen()),
      ],
    ));
  }
}
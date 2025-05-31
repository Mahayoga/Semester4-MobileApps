import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
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
import 'package:get/get.dart';
import 'page/profil/profil.dart';
import 'page/bahasa/lang.dart';
import 'page/profil/profil.dart';

void main() {
  // debugPaintSizeEnabled = true; // Lihat bounding box
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contoh Routing Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/daftar': (context) => DaftarPage(),
        '/buat-username': (context) => buat_usernamePage(email: ''),
        '/akun-terverifikasi': (context) => akun_terverifikasiPage(email: ''),
        '/verifikasi-email': (context) => VerifikasiEmailPage(email: ''),

        // Forgot password flow
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/verification': (context) => VerificationScreen(email: ''),
        '/new-password': (context) => NewPasswordScreen(),

        // Dashboard
        '/dashboard': (context) => DashboardPage(),

        // Profil
        '/ProfilePage' : (context) => ProfilePagen()
      },
    );
  }
}
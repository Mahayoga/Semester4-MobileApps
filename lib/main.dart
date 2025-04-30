import 'package:flutter/material.dart';
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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Contoh Routing Flutter',
      initialRoute: '/',
      routes: {
        '/': (context) => LandingPage(),
        '/login': (context) => LoginPage(),
        '/daftar': (context) => DaftarPage(),
        '/buat-username': (context) => buat_usernamePage(),
        '/akun-terverifikasi': (context) => akun_terverifikasiPage(),
        '/verifikasi-email': (context) => VerifikasiEmailPage(),

        // Forgot password flow
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/verification': (context) => VerificationScreen(),
        '/new-password': (context) => NewPasswordScreen(),

        // Dashboard
        '/dashboard': (context) => DashboardPage()
      },
    );
  }
}

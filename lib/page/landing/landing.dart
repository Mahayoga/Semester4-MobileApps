import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_diabetes/page/login/login.dart';

class LandingPage extends StatefulWidget {
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 239, 197, 243),
        surfaceTintColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'LOGIN',
                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(() => LoginPage());
                    }
                  )
                ),
                const SizedBox(width: 8),
                const Text("|", style: TextStyle(color: Colors.grey, fontFamily: 'Comfortaa')),
                const SizedBox(width: 8),
                RichText(
                  text: TextSpan(
                    text: 'DAFTAR',
                    style: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Comfortaa'),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, '/daftar');
                    }
                  )
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 239, 197, 243),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Gambar
                Stack(
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(),
                    ),
                    Positioned(
                      top:
                          -20, // 🔽 ubah nilai ini untuk mengatur posisi vertikal
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/images/person_landing.png',
                        height: 400,
                      ),
                    ),
                  ],
                ),

                // Konten bawah
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(230),
                      topRight: Radius.circular(230),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Selamat Datang di',
                        style: TextStyle(fontSize: 16, color: Colors.black54, fontFamily: 'Comfortaa'),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Teman-Sehat',
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B3BE8),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Hai! Kami siap membantu anda\nberkonsultasi dengan aplikasi kita.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.black54, fontFamily: 'Comfortaa',),
                      ),
                      const SizedBox(height: 24),
                      const Icon(Icons.star_border, color: Colors.purple),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          // Navigasi ke halaman login
                          Get.to(() => LoginPage());
                        },
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(
                            fontFamily: 'Comfortaa',
                          ),
                          backgroundColor: const Color(0xFF8B3BE8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 48, vertical: 14),
                        ),
                        child: const Text(
                          'Mulai sekarang!',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

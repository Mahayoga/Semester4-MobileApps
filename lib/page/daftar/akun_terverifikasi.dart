import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_diabetes/page/daftar/buat_username.dart';

class akun_terverifikasiPage extends StatefulWidget {
  final String email;
  akun_terverifikasiPage({super.key, required this.email});

  @override
  State<akun_terverifikasiPage> createState() => _akun_terverifikasiPage();
}

class _akun_terverifikasiPage extends State<akun_terverifikasiPage> {

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10),
            ],
          ),
          width: 400, // supaya gak terlalu lebar
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.mail_outline,
                size: 80,
                color: Color(0xFF8B3BE8), // warna ungu
              ),
              const SizedBox(height: 16),
              const Text(
                'Akun anda telah di-verifikasi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              const Divider( // garis horizontal
                color: Colors.grey,
                thickness: 1,
              ),
              const SizedBox(height: 16),
              const Text(
                'Terima kasih telah bergabung dengan HealthDream',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => buat_usernamePage(email: widget.email));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8B3BE8),
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  shadowColor: Color(0xFF8B3BE8).withOpacity(0.5),
                ),
                child: const Text(
                  'Lanjutkan',
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

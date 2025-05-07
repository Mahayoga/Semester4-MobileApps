import 'package:flutter/material.dart';

class VerifikasiEmailPage extends StatelessWidget {
  const VerifikasiEmailPage({super.key});

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
                'Verifikasi email anda',
                style: TextStyle(
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
                'Check email anda & klik link\nuntuk meng-aktivasi akun anda.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/akun-terverifikasi');
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
                  'Kirim link verifikasi',
                  style: TextStyle(
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

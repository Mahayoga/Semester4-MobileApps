import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFEADCFB), Color(0xFFF8F4FB)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // SafeArea + Scroll View
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Login & Daftar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 8),
                        Text("|", style: TextStyle(color: Colors.grey)),
                        SizedBox(width: 8),
                        Text("Daftar", style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Gambar Dokter
                  Image.asset(
                    'assets/images/person_landing.png',
                    height: 250,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 20),

                  // Kontainer bawah (putih)
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Selamat Datang di',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Teman–Sehat',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B3BE8),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Hai! Kami siap membantu anda\nberkonsultasi dengan aplikasi kita.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 24),
                        const Icon(Icons.star_border, color: Colors.purple),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            // Aksi saat tombol ditekan
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8B3BE8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
                          ),
                          child: const Text(
                            'Mulai sekarang!',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

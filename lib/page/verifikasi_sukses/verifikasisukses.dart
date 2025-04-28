import 'package:flutter/material.dart';
import '../buatusernameapp/buatusernameapp.dart';

class SuccessVerificationPage extends StatelessWidget {
  const SuccessVerificationPage({Key? key}) : super(key: key);

  void _goToNextPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BuatUsernameApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 20,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.purple),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.mark_email_read_outlined, size: 48, color: Colors.purple),
                    const SizedBox(height: 16),
                    const Text(
                      'Akun anda telah di-verifikasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(height: 30),
                    const Text(
                      'Terimakasih telah bergabung bersama Teman-Sehat.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _goToNextPage(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 8,
                          shadowColor: Colors.purpleAccent,
                        ),
                        child: const Text(
                          'Lanjutkan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Halaman berikutnya', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

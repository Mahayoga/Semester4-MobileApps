import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../verifikasi_sukses/verifikasisukses.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  Future<void> _openEmailApp(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '',
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
      // Setelah membuka email, lanjut ke halaman berikutnya
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SuccessVerificationPage()),
      );  
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka aplikasi email')),
      );
    }
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
                    const Icon(Icons.email, size: 48, color: Colors.purple),
                    const SizedBox(height: 16),
                    const Text(
                      'Verifikasi email anda',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Divider(height: 30),
                    const Text(
                      'Check email anda & klik link\nuntuk meng-aktivasi akun anda.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _openEmailApp(context),
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
                          'Kirim link verifikasi',
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
        child: Text('Ini halaman berikutnya', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'verification_screen.dart'; // <-- tambahin import ini!

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 100, color: Colors.purple),
            SizedBox(height: 20),
            Text(
              'Lupa Password?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Tolong masukkan email anda untuk menerima kode verifikasi.'),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: Text('Coba cara lain', style: TextStyle(color: Colors.purple)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => VerificationScreen()), // <-- sekarang aman!
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                minimumSize: Size(double.infinity, 50),
              ),
              child: const Text(
                  'Kirim',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'new_password_screen.dart'; // <-- ini tambahan!

class VerificationScreen extends StatelessWidget {
  final List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.email_outlined, size: 100, color: Colors.purple),
            SizedBox(height: 20),
            Text(
              'Verifikasi Email Anda',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Tolong masukkan 4 digit kode yang telah kita kirimkan ke email Anda.'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: controllers[index],
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: Text('Kirim Ulang Kode', style: TextStyle(color: Colors.purple)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NewPasswordScreen()), // <-- perbaiki di sini
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

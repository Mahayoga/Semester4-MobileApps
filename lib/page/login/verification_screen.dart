import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as myhttp;
import 'package:mobile_diabetes/page/dashboard/dashboard.dart';
import 'new_password_screen.dart'; // <-- ini tambahan!

class VerificationScreen extends StatefulWidget {
  final String email;
  const VerificationScreen({super.key, required this.email});
  @override
  State<VerificationScreen> createState() => _VerificationScreen();
}

class _VerificationScreen extends State<VerificationScreen> {
  
  final TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(Icons.email_outlined, size: 100, color: Colors.purple),
            SizedBox(height: 20),
            Text(
              'Reset password anda',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Reset password anda di bawah ini'),
            SizedBox(height: 10),
            TextField(
              controller: passwordC,
              decoration: InputDecoration(
                hintText: 'Masukkan password baru anda',
                labelText: 'Input password baru',
                filled: true,
                fillColor: const Color(0xFFF2F2F2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _handleResetPassword(context, passwordC, widget.email);
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

  Future<void> _handleResetPassword(BuildContext context, TextEditingController passwordC, String email) async {
    try {
      var responses = await myhttp.post(Uri.parse('http://127.0.0.1:5000/reset-password'),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'email': email,
          'password': passwordC.text,
          'action': 'reset_password'
        })
      );

      if(!context.mounted) return;

      if(responses.statusCode == 200) {
        Map<String, dynamic> theData = jsonDecode(responses.body);
        if(theData['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              showCloseIcon: true,
              duration: Duration(seconds: 2),
              content: Text('Reset password berhasil!')
            ),
          );
          Get.to(() => DashboardPage());
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              showCloseIcon: true,
              duration: Duration(seconds: 2),
              content: Text('Reset password gagal, kesalahan dari server!')
            ),
          );
        }
      }
    } catch(e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          showCloseIcon: true,
          duration: Duration(seconds: 2),
          content: Text('Reset password gagal, kesalahan dari server!')
        ),
      );
    }
  }

}

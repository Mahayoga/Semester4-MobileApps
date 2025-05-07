import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as myhttp;

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Container(
            width: 360,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Selamat Datang Kembali",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: "Belum mempunyai akun? ",
                    style: TextStyle(color: Colors.black87),
                    children: [
                      TextSpan(
                        text: "Daftar disini",
                        style: TextStyle(color: Colors.purple),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/daftar');
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                // Email field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: emailC,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Password field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: passwordC,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      text: 'Lupa Password?',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/forgot-password');
                        },
                      style: TextStyle(
                        color: Colors.purple
                      )
                    ),
                  )
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    handleLogin(context, emailC, passwordC);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                    shadowColor: Colors.purpleAccent,
                  ),
                  child: Text("Lanjutkan", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}


Future<void> handleLogin(BuildContext context, TextEditingController emailC, TextEditingController passwordC) async {
  try {
    var responses = await myhttp.post(Uri.parse('http://127.0.0.1:5000/login'),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'email': emailC.text,
      'password': passwordC.text
    })
  );

  if (!context.mounted) return;

  if(responses.statusCode == 200) {
    Map<String, dynamic> theData = jsonDecode(responses.body);
    if(theData['status'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          showCloseIcon: true,
          content: Text('Login berhasil')
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Session Gagal')
        ),
      );
      // Navigator.pushNamed(context, '/dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          showCloseIcon: true,
          content: Text('Kesalahan terjadi: ${theData["msg"]}')
        ),
      );
    }
  }
  } catch(e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        showCloseIcon: true,
        content: Text('Error: Koneksi gagal, silahkan coba lagi nanti')
      ),
    );
  }
}
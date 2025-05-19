import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as myhttp;

class DaftarPage extends StatefulWidget {
  @override
  State<DaftarPage> createState() => _DaftarPage();
}

class _DaftarPage extends State<DaftarPage> {

  final TextEditingController namaDepanC = TextEditingController();
  final TextEditingController namaBelakangC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController passwordConfirmC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Buat akun anda',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sudah mempunyai akun? '),
                    RichText(
                      text: TextSpan(
                        text: 'Login disini',
                        style: TextStyle(
                          color: Colors.purple,
                          decoration: TextDecoration.underline
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, '/login');
                          }
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Input Email
                TextField(
                  controller: namaDepanC,
                  decoration: InputDecoration(
                    hintText: 'Nama depan',
                    filled: true,
                    fillColor: const Color(0xFFF2F2F2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: namaBelakangC,
                  decoration: InputDecoration(
                    hintText: 'Nama belakang',
                    filled: true,
                    fillColor: const Color(0xFFF2F2F2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: emailC,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: const Color(0xFFF2F2F2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Input Password
                TextField(
                  controller: passwordC,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: const Color(0xFFF2F2F2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Input Ulang Password
                TextField(
                  controller: passwordConfirmC,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Masukkan ulang password',
                    filled: true,
                    fillColor: const Color(0xFFF2F2F2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Tombol Lanjutkan
                ElevatedButton(
                  onPressed: () {
                    var data = {
                      'nama_depan': namaDepanC.text,
                      'nama_belakang': namaBelakangC.text,
                      'email': emailC.text,
                      'password': passwordC.text,
                      'password_ulang': passwordConfirmC.text,
                      'role': 'user'
                    };
                    handleRegister(context, data);
                    // Navigator.pushNamed(context, '/verifikasi-email'); // <-- ini sudah bener!
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B3BE8),
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: Colors.blueAccent,
                    elevation: 6,
                  ),
                  child: const Text(
                    'Lanjutkan',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  Future<void> handleRegister(BuildContext context, Map<String, dynamic> data) async {
    try {
      if(data['nama_depan'] == '' || data['nama_belakang'] == '' || data['email'] == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            showCloseIcon: true,
            content: Text('Silahkan lengkapi form terlebih dahulu')
          ),
        );
        return;
      }
      if(data['password'] == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            showCloseIcon: true,
            content: Text('Masukkan password anda')
          ),
        );
        return;
      }
      if(data['password'] != data['password_ulang']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            showCloseIcon: true,
            content: Text('Password yang anda masukkan tidak sama. Silahkan cek ulang password anda!')
          ),
        );
        return;
      }

      var responses = await myhttp.post(Uri.parse('http://127.0.0.1:5000/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data)
      );

      if (!context.mounted) return;

      if(responses.statusCode == 200) {
        Map<String, dynamic> theData = jsonDecode(responses.body);
        if(theData['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              showCloseIcon: true,
              duration: Duration(seconds: 5),
              content: Text('Daftar berhasil, anda akan diarahkan ke halaman login setelah 5 detik')
            ),
          );
          Future.delayed(Duration(seconds: 5), () {
            Navigator.pushNamed(context, '/login');
          });
        } else if(theData['status'] == 'error') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              showCloseIcon: true,
              duration: Duration(seconds: 2),
              content: Text('Daftar gagal, terjadi kesalahan')
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              showCloseIcon: true,
              duration: Duration(seconds: 2),
              content: Text('Daftar gagal, silahkan periksa koneksi anda lalu coba lagi')
            ),
          );
        }
      }
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          showCloseIcon: true,
          duration: Duration(seconds: 2),
          content: Text('Daftar gagal, terjadi kesalahan pada server!')
        ),
      );
    }
  }
}

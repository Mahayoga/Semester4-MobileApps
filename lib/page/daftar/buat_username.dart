import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as myhttp;
import 'package:mobile_diabetes/page/dashboard/dashboard.dart';

class buat_usernamePage extends StatefulWidget {
  final String email;
  buat_usernamePage({super.key, required this.email});
  @override
  State<buat_usernamePage> createState() => _buat_usernamePage();
}

class _buat_usernamePage extends State<buat_usernamePage> {
  final TextEditingController usernameC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Buat nama panggilan anda',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Nama panggilan anda akan tampil di halaman dashboard nanti!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Comfortaa',
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: usernameC,
              style: TextStyle(
                fontFamily: 'Comfortaa',
              ),
              decoration: InputDecoration(
                hintText: 'Masukkan disini',
                filled: true,
                fillColor: const Color(0xFFF2F2F2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // print(widget.email);
                _handleCreateUsername(context, usernameC.text, widget.email);
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
                'Selesai',
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCreateUsername(BuildContext context, String username, String email) async {
    try {
      var responses = await myhttp.post(Uri.parse('http://127.0.0.1:5000/create-username'),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'username': username,
          'email': email
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
              content: Text('Buat username berhasil, anda akan diarahkan ke dashboard!')
            ),
          );
          Future.delayed(Duration(seconds: 2), () {
            Get.to(() => DashboardPage());
          });
        } else if(theData['status'] == 'error') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              showCloseIcon: true,
              duration: Duration(seconds: 2),
              content: Text('Buat username gagal, terjadi kesalahan pada server!')
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
          content: Text('Buat username gagal, terjadi kesalahan pada server!')
        ),
      );
    }
  }
}

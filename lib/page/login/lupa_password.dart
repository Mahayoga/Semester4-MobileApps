import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as myhttp;
import 'verification_screen.dart'; // <-- tambahin import ini!

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends State<ForgotPasswordScreen> {
  
  bool isVerifiying = false;
  String textActionBtn = 'Kirim kode verifikasi';
  final TextEditingController emailC = TextEditingController();
  final TextEditingController numOneC = TextEditingController();
  final TextEditingController numTwoC = TextEditingController();
  final TextEditingController numThreeC = TextEditingController();
  final TextEditingController numFourC = TextEditingController();
  final TextEditingController numFiveC = TextEditingController();
  final TextEditingController numSixC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final FocusScopeNode focus = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.lock_outline,
              size: 80,
              color: Color(0xFF8B3BE8), // warna ungu
            ),
            const SizedBox(height: 16),
            const Text(
              'Masukkan email anda untuk melanjutkan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            if(isVerifiying)
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: TextField(
                      controller: numOneC,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0)
                      ),
                      decoration: InputDecoration(
                        hintText: '-',
                        labelStyle: TextStyle(
                          fontFamily: 'Comfortaa',
                        ),
                        hintStyle: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(5)
                      ),
                      onChanged: (value) {
                        if(value.length == 1) {
                          focus.nextFocus();
                        } else if(value.length > 1) {
                          numOneC.text = value[value.length - 1];
                          focus.nextFocus();
                        }
                      },
                    )
                  ),
                  Expanded(
                    child: TextField(
                      controller: numTwoC,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0)
                      ),
                      decoration: InputDecoration(
                        hintText: '-',
                        hintStyle: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(5)
                      ),
                      onChanged: (value) {
                        if(value.length == 1) {
                          focus.nextFocus();
                        } else if(value.length > 1) {
                          numOneC.text = value[value.length - 1];
                          focus.nextFocus();
                        }
                      },
                    )
                  ),
                  Expanded(
                    child: TextField(
                      controller: numThreeC,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0)
                      ),
                      decoration: InputDecoration(
                        hintText: '-',
                        hintStyle: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(5)
                      ),
                      onChanged: (value) {
                        if(value.length == 1) {
                          focus.nextFocus();
                        } else if(value.length > 1) {
                          numOneC.text = value[value.length - 1];
                          focus.nextFocus();
                        }
                      },
                    )
                  ),
                  Expanded(
                    child: TextField(
                      controller: numFourC,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0)
                      ),
                      decoration: InputDecoration(
                        hintText: '-',
                        hintStyle: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(5)
                      ),
                      onChanged: (value) {
                        if(value.length == 1) {
                          focus.nextFocus();
                        } else if(value.length > 1) {
                          numOneC.text = value[value.length - 1];
                          focus.nextFocus();
                        }
                      },
                    )
                  ),
                  Expanded(
                    child: TextField(
                      controller: numFiveC,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0)
                      ),
                      decoration: InputDecoration(
                        hintText: '-',
                        hintStyle: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(5)
                      ),
                      onChanged: (value) {
                        if(value.length == 1) {
                          focus.nextFocus();
                        } else if(value.length > 1) {
                          numOneC.text = value[value.length - 1];
                          focus.nextFocus();
                        }
                      },
                    )
                  ),
                  Expanded(
                    child: TextField(
                      controller: numSixC,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0)
                      ),
                      decoration: InputDecoration(
                        hintText: '-',
                        hintStyle: TextStyle(
                          fontFamily: 'Comfortaa',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF2F2F2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.all(5)
                      ),
                      onChanged: (value) {
                        if(value.length == 1) {
                          focus.nextFocus();
                        } else if(value.length > 1) {
                          numOneC.text = value[value.length - 1];
                          focus.nextFocus();
                        }
                      },
                    )
                  ),
                ],
              ),
            if(!isVerifiying)
              TextField(
                controller: emailC,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                ),
                decoration: InputDecoration(
                  labelText: 'Email anda',
                  labelStyle: TextStyle(
                    fontFamily: 'Comfortaa',
                  ),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10)
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              'Cek email anda dan salin kode\nuntuk me-reset password akun anda.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Comfortaa',
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                if(isVerifiying) {
                  var kode = numOneC.text + numTwoC.text + numThreeC.text + numFourC.text + numFiveC.text + numSixC.text;
                  print(kode);
                  _handleCodeVerification(context, kode, emailC.text);
                } else {
                  _handleVerification(context, emailC.text);
                }
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
              child: Text(
                textActionBtn,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleVerification(BuildContext context, String email) async {
    try {
      var responses = await myhttp.post(
        Uri.parse('http://127.0.0.1:5000/verifikasi-email'),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'email': email,
          'action': 'verification_email',
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
              duration: Duration(seconds: 2),
              content: Text('Kode verifikasi terkirim!')
            ),
          );
          setState(() {
            textActionBtn = 'Lanjutkan!';
            isVerifiying = true;
          });
        } else if(theData['status'] == 'need_action') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.yellow,
              showCloseIcon: true,
              duration: Duration(seconds: 2),
              content: Text('Email sepertinya belum terdaftar!')
            ),
          );
        } else if(theData['status'] == 'error') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              showCloseIcon: true,
              duration: Duration(seconds: 2),
              content: Text('Terjadi kesalahan pada server!')
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
          content: Text('Verifikasi gagal, terjadi kesalahan pada server!')
        ),
      );
    }
  }

  Future<void> _handleCodeVerification(BuildContext context, String kode, String email) async {
    try {
      var responses = await myhttp.post(
        Uri.parse('http://127.0.0.1:5000/verifikasi-email'),
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'email': email,
          'kode': kode,
          'action': 'verification_email_code',
          'detail': 'reset_password'
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
              duration: Duration(seconds: 2),
              content: Text('Verifikasi berhasil!')
            ),
          );
          Future.delayed(Duration(seconds: 1), () {
              Get.to(() => VerificationScreen(email: email));
            }
          );
        } else if(theData['status'] == 'need_action') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              showCloseIcon: true,
              duration: Duration(seconds: 2),
              content: Text('Verifikasi gagal, email tidak ditemukan!')
            ),
          );
        } else if(theData['status'] == 'error') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              showCloseIcon: true,
              duration: Duration(seconds: 2),
              content: Text('Verifikasi gagal, terjadi kesalahan pada server!')
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
          content: Text('Verifikasi gagal, terjadi kesalahan pada server!')
        ),
      );
    } finally {
      setState(() {
        isVerifiying = false;
        textActionBtn = 'Kirim kode verifikasi';
      });
    }
  }
}
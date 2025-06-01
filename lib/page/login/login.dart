import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as myhttp;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:mobile_diabetes/page/daftar/buat_username.dart';
import 'package:mobile_diabetes/page/daftar/daftar.dart';
import 'package:mobile_diabetes/page/daftar/verifikasi_email.dart';
import 'package:mobile_diabetes/page/dashboard/dashboard.dart';
import 'package:mobile_diabetes/page/login/lupa_password.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  bool _isLogin = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Selamat Datang Kembali",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: "Belum mempunyai akun? ",
                      style: TextStyle(color: Colors.black87, fontFamily: 'Comfortaa',),
                      children: [
                        TextSpan(
                          text: "Daftar disini",
                          style: TextStyle(color: Colors.purple, fontFamily: 'Comfortaa',),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => DaftarPage());
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
                      style: TextStyle(fontFamily: 'Comfortaa',),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        hintStyle: TextStyle(fontFamily: 'Comfortaa',),
                        labelStyle: TextStyle(fontFamily: 'Comfortaa',)
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
                      style: TextStyle(fontFamily: 'Comfortaa',),
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(fontFamily: 'Comfortaa',),
                        labelStyle: TextStyle(fontFamily: 'Comfortaa',)
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
                            Get.to(() => ForgotPasswordScreen());
                          },
                        style: TextStyle(
                          color: Colors.purple,
                          fontFamily: 'Comfortaa',
                        )
                      ),
                    )
                  ),
                  SizedBox(height: 24),
                  if(_isLogin)
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 100,
                          child: LoadingIndicator(
                            indicatorType: Indicator.lineScale, /// Required, The loading type of the widget
                            colors: const [
                              Colors.purple,
                              Color.fromARGB(255, 198, 31, 228),
                              Color.fromARGB(255, 220, 88, 243),
                              Color.fromARGB(255, 208, 131, 221),
                            ],
                            strokeWidth: 2,
                          ),
                        ),
                        SizedBox(height: 24),
                      ]
                    ),
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
                    child: Text("Lanjutkan", style: TextStyle(color: Colors.white, fontFamily: 'Comfortaa',)),
                  ),
                ],
              ),
            ),
          ]
        ),
      )
    );
  }

  Future<void> handleLogin(BuildContext context, TextEditingController emailC, TextEditingController passwordC) async {
    try {
      setState(() {
        _isLogin = true;
      });
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
        Get.to(() => DashboardPage());
      } else if(theData['status'] == 'need_action') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepOrange,
            showCloseIcon: true,
            content: Text(
              'Email kamu perlu verifikasi sebelum login. Anda akan diarahkan ke halaman verifikasi email!',
              style: TextStyle(
                fontFamily: 'Comfortaa',
              ),
            )
          ),
        );
        Future.delayed(Duration(seconds: 3), () {
          Get.to(() => VerifikasiEmailPage(email: emailC.text));
        });
      } else if(theData['status'] == 'need_action_username') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.deepOrange,
            showCloseIcon: true,
            content: Text(
              'Kamu belum mendaftarkan username. Anda akan diarahkan kedalam halaman username!',
              style: TextStyle(
                fontFamily: 'Comfortaa',
              ),
            )
          ),
        );
        Future.delayed(Duration(seconds: 3), () {
          Get.to(() => buat_usernamePage(email: emailC.text));
        });
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
    } finally {
      setState(() {
        _isLogin = false;
      });
    }
  }
}
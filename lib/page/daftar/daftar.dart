import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as myhttp;
import 'package:intl/intl.dart';
import 'package:mobile_diabetes/page/daftar/verifikasi_email.dart';

class DaftarPage extends StatefulWidget {
  @override
  State<DaftarPage> createState() => _DaftarPage();
}

class _DaftarPage extends State<DaftarPage> {

  final TextEditingController namaDepanC = TextEditingController();
  final TextEditingController namaBelakangC = TextEditingController();
  final TextEditingController tanggalLahirC = TextEditingController();
  final TextEditingController umurC = TextEditingController();
  final TextEditingController genderC = TextEditingController();
  final TextEditingController alamatC = TextEditingController();
  final TextEditingController emailC = TextEditingController();
  final TextEditingController passwordC = TextEditingController();
  final TextEditingController passwordConfirmC = TextEditingController();

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Buat akun anda',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah mempunyai akun? ',
                        style: TextStyle(
                          fontFamily: 'Comfortaa'
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Login disini',
                          style: TextStyle(
                            color: Colors.purple,
                            fontFamily: 'Comfortaa',
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
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView(
                      children: [
                        Row(
                          spacing: 15,
                          children: [
                            Expanded(
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Comfortaa',
                                ),
                                controller: namaDepanC,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  hintText: 'Nama depan',
                                  filled: true,
                                  fillColor: const Color(0xFFF2F2F2),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Comfortaa',
                                ),
                                controller: namaBelakangC,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  hintText: 'Nama belakang',
                                  filled: true,
                                  fillColor: const Color(0xFFF2F2F2),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          spacing: 15,
                          children: [
                            Expanded(
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Comfortaa'
                                ),
                                controller: tanggalLahirC,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  filled: true,
                                  fillColor: const Color(0xFFF2F2F2),
                                  labelStyle: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'Comfortaa'
                                  ),
                                  labelText: 'Tanggal Lahir',
                                  hintText: 'Pilih tanggal lahir',
                                  suffixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                readOnly: true,
                                onTap: () => _selectDate(context),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Comfortaa'
                                ),
                                keyboardType: TextInputType.numberWithOptions(),
                                controller: umurC,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  hintText: 'Umur',
                                  filled: true,
                                  fillColor: const Color(0xFFF2F2F2),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        DropdownButtonFormField(
                          hint: Text(
                            'Pilih jenis kelamin',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            filled: true,
                            fillColor: const Color(0xFFF2F2F2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              child: Text(
                                'Laki - laki',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Comfortaa'
                                ),
                              ),
                              value: 'l',
                            ),
                            DropdownMenuItem(
                              child: Text(
                                'Perempuan',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Comfortaa'
                                ),
                              ),
                              value: 'p',
                            )
                          ],
                          onChanged: (value) {
                            genderC.text = value.toString();
                          },
                        ),
                        SizedBox(height: 15),
                        TextField(
                          controller: alamatC,
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Comfortaa'
                          ),
                          decoration: InputDecoration(
                            hintText: 'Alamat',
                            filled: true,
                            fillColor: const Color(0xFFF2F2F2),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextField(
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Comfortaa'
                          ),
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
                        SizedBox(height: 15),
                        TextField(
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Comfortaa'
                          ),
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
                        SizedBox(height: 15),
                        TextField(
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Comfortaa'
                          ),
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
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      var data = {
                        'nama_depan': namaDepanC.text,
                        'nama_belakang': namaBelakangC.text,
                        'tanggal_lahir': tanggalLahirC.text,
                        'umur': umurC.text,
                        'gender': genderC.text,
                        'alamat': alamatC.text,
                        'email': emailC.text,
                        'password': passwordC.text,
                        'password_ulang': passwordConfirmC.text,
                        'role': 'user'
                      };
                      print(data);
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
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }

  bool checkEmail(String email) {
    bool result = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return result;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        tanggalLahirC.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  Future<void> handleRegister(BuildContext context, Map<String, dynamic> data) async {
    try {
      if(data['nama_depan'] == '' || data['nama_belakang'] == '' || data['tanggal_lahir'] == '' || data['umur'] == '' || data['gender'] == '' || data['alamat'] == '' || data['email'] == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            showCloseIcon: true,
            content: Text('Silahkan lengkapi form terlebih dahulu')
          ),
        );
        return;
      }
      if(!checkEmail(emailC.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            showCloseIcon: true,
            content: Text('Email tidak valid!')
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
              content: Text('Daftar berhasil, selanjutnya anda harus verifikasi email terlebih dahulu')
            ),
          );
          Future.delayed(Duration(seconds: 5), () {
            Get.to(() => VerifikasiEmailPage(email: data['email']));
          });

        } else if(theData['status'] == 'need_action') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              showCloseIcon: true,
              duration: Duration(seconds: 5),
              content: Text(theData['msg'])
            ),
          );
          Future.delayed(Duration(seconds: 5), () {
            Get.to(VerifikasiEmailPage(email: data['email']));
          });
        } else if(theData['status'] == 'occupied') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              showCloseIcon: true,
              content: Text('Email sudah digunakan!')
            ),
          );
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/language_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePagen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePagen();
}

class _ProfilePagen extends State<ProfilePagen> {
  final BahasaController languageController = Get.put(BahasaController());
  String idUser = '';
  String idPasien = '';
  String namaDepan = '';
  String namaBelakang = '';
  String tanggalLahir = '';
  String umur = '';
  String gender = '';
  String alamat = '';
  String username = '';
  String role = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _getDataUser();
  }

  void _onLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Get.offAllNamed('/');
  }

  void _onHistory() {
    Get.toNamed('/history');
  }

  void _onNotification() {
    Get.toNamed('/notification');
  }

  Future<void> _getDataUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        idUser = prefs.getString('id_user')!;
        idPasien = prefs.getString('id_pasien')!;
        namaDepan = prefs.getString('nama_depan')!;
        namaBelakang = prefs.getString('nama_belakang')!;
        tanggalLahir = prefs.getString('tanggal_lahir')!;
        umur = prefs.getString('umur')!;
        gender = prefs.getString('gender')!;
        alamat = prefs.getString('alamat')!;
        username = prefs.getString('username')!;
        role = prefs.getString('role')!;
        email = prefs.getString('email')!;
      });
    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back and Title
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Get.back(),
                  ),
                  Text('setting'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              // Profile Box
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('images/profile_picture.jpeg'), // ganti dengan asset gambar kamu
                      radius: 30,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Halo, ' + username, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(email),
                        ],
                      )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Content
              const Text('Content'),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.history, color: Colors.purple),
                title: Text('history'.tr),
                trailing: const Icon(Icons.chevron_right),
                onTap: _onHistory,
              ),
              ListTile(
                leading: const Icon(Icons.notifications, color: Colors.purple),
                title: Text('notification'.tr),
                trailing: const Icon(Icons.chevron_right),
                onTap: _onNotification,
              ),
              const SizedBox(height: 20),
              const Text('Preferences'),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.language, color: Colors.purple),
                title: Text('language'.tr),
                trailing: DropdownButton<String>(
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(value: 'id', child: Text('Indonesia')),
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'es', child: Text('Spanish')),
                  ],
                  onChanged: (val) => languageController.changeLanguage(val!),
                  icon: const Icon(Icons.expand_more),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: Text('logout'.tr, style: const TextStyle(color: Colors.red)),
                onTap: _onLogout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

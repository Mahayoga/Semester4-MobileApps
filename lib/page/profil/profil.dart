import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/language_controller.dart';

class ProfilePagen extends StatelessWidget {
  final BahasaController languageController = Get.put(BahasaController());

  void _onLogout() {
    Get.offAllNamed('/login');
  }

  void _onHistory() {
    Get.toNamed('/history');
  }

  void _onNotification() {
    Get.toNamed('/notification');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Colors.purple,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.description), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
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
                      backgroundImage: AssetImage('assets/avatar.png'), // ganti dengan asset gambar kamu
                      radius: 30,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Kahfi Adam', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('kahfiadam@gmail.com'),
                      ],
                    )
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

              // Language Dropdown
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

              // Logout
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

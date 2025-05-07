import 'package:flutter/material.dart';
import '../welcomepage/welcomepage.dart';

void main() {
  runApp(const BuatUsernameApp());
}

class BuatUsernameApp extends StatelessWidget {
  const BuatUsernameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BuatUsernamePage(),
    );
  }
}

class BuatUsernamePage extends StatefulWidget {
  @override
  _BuatUsernamePageState createState() => _BuatUsernamePageState();
}

class _BuatUsernamePageState extends State<BuatUsernamePage> {
  final TextEditingController _usernameController = TextEditingController();

  void _onSelesaiPressed() {
    String username = _usernameController.text.trim();
    if (username.isNotEmpty) {
      // Username diisi, lanjut ke WelcomePage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomePage(username: username),
        ),
      );
    } else {
      // Kalau kosong kasih feedback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Silakan masukkan nama panggilan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Buat nama panggilan anda',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Nama panggilan anda akan tampil di halaman dashboard nanti!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Masukkan disini',
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onSelesaiPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B3D8B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      shadowColor: Colors.purpleAccent,
                    ),
                    child: const Text(
                      'Selesai',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
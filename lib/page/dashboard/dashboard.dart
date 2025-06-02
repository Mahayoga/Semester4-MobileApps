import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mobile_diabetes/page/controller/language_controller.dart';
import 'package:mobile_diabetes/page/foodpage/foodpage.dart';
import 'package:mobile_diabetes/page/landing/landing.dart';
import 'package:mobile_diabetes/page/profil/profil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as myhttp;
import 'dart:math';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class PredictionModel {
  final String date;
  final String result;
  final double probability;
  final Map<String, dynamic> inputData;

  PredictionModel({
    required this.date,
    required this.result,
    required this.probability,
    required this.inputData,
  });

  Map<String, dynamic> toJson() => {
    'date': date,
    'result': result,
    'probability': probability,
    'inputData': inputData,
  };

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      date: json['date'],
      result: json['result'],
      probability: json['probability'].toDouble(),
      inputData: json['inputData'],
    );
  }
}

// Storage key for predictions
const String PREDICTIONS_KEY = 'predictions';

// Function to save prediction to storage
Future<void> savePrediction(PredictionModel prediction) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> predictions = prefs.getStringList(PREDICTIONS_KEY) ?? [];
  predictions.add(jsonEncode(prediction.toJson()));
  await prefs.setStringList(PREDICTIONS_KEY, predictions);
}

// Function to get all predictions from storage
Future<List<PredictionModel>> getPredictions() async {
  final prefs = await SharedPreferences.getInstance();
  List<String> predictions = prefs.getStringList(PREDICTIONS_KEY) ?? [];
  return predictions
      .map((str) => PredictionModel.fromJson(jsonDecode(str)))
      .toList();
}

// Updated prediction function
Future<Map<String, dynamic>> predictDiabetes(Map<String, dynamic> data) async {
  double bmi = data['weight'] / pow(data['height'] / 100, 2);
  print(data);
  print(pow(data['height'] / 100, 2));
  print(bmi);
  try {
    var responses = await myhttp.post(
      Uri.parse('http://127.0.0.1:5000/lakukan-prediksi'),
      headers: {
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'pregnancies': data['pregnancies'],
        'glucose': data['glucose'],
        'blood_pressure': data['bloodPressure'],
        'skin_thickness': data['skinThickness'],
        'insulin': data['insulin'],
        'height': data['height'],
        'weight': data['weight'],
        'age': data['age'],
        'diabetes_pedigree_function': data['familyHistoryScore']
      })
    );
    // Simulate prediction logic
    double probability = 87.0; // This should be replaced with actual ML model
    String result = probability > 50 ? 'Positif' : 'Negatif';
    
    // Create prediction model
    final prediction = PredictionModel(
      date: DateTime.now().toString().split(' ')[0],
      result: result,
      probability: probability,
      inputData: data,
    );

    // Save prediction
    await savePrediction(prediction);

    return {
      'probability': probability,
      'status': result,
    };
  } catch(e) {
    return {
      'status': 'error',
    };
  }
}

// Updated history function
Future<List<Map<String, dynamic>>> fetchHistory() async {
  List<PredictionModel> predictions = await getPredictions();
  return predictions.map((p) => {
    'date': p.date,
    'result': p.result,
    'probability': p.probability,
  }).toList();
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeContent(),
    const PredictionFormPage(),
    const HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Prediksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // Tombol notifikasi
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationPage()),
              );
            },
          ),

          // Avatar bisa diklik
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePagen()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('images/profile_picture.jpeg'),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Chart
            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const SimpleLineChart(),
            ),
            const SizedBox(height: 20),

            // Rekomendasi Klinik
            const Text(
              'Rekomendasi Klinik Terdekat',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                try {
                  await openNearbyHospitals();
                } catch (e) {
                  // Tampilkan pesan error jika gagal
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Gagal membuka Google Maps: $e')),
                  );
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('images/rekomendasi_map.png'),
              ),
            ),
            const SizedBox(height: 20),

            // Rekomendasi Makanan
            const Text(
              'Rekomendasi Makanan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox( 
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  foodCard(context, 'images/food1.png'),
                  foodCard(context, 'images/food2.png'),
                  foodCard(context, 'images/food3.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget foodCard(BuildContext context, String imagePath) {
    return GestureDetector(
      onTap: () {
        if (imagePath.contains('food1')) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Food1Page()),
          );
        } else if (imagePath.contains('food2')) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Food2Page()),
          );
        } else if (imagePath.contains('food3')) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Food3Page()),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class SimpleLineChart extends StatelessWidget {
  const SimpleLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: Colors.purple,
            barWidth: 3,
            spots: const [
              FlSpot(0, 3),
              FlSpot(1, 1.5),
              FlSpot(2, 2.8),
              FlSpot(3, 2),
              FlSpot(4, 3.5),
              FlSpot(5, 1),
              FlSpot(6, 4),
            ],
          ),
        ],
      ),
    );
  }
}

class PredictionFormPage extends StatefulWidget {
  const PredictionFormPage({super.key});

  @override
  State<PredictionFormPage> createState() => _PredictionFormPageState();
}

class _PredictionFormPageState extends State<PredictionFormPage> {
  final TextEditingController pregnancies = TextEditingController();
  final TextEditingController glucose = TextEditingController();
  final TextEditingController bloodPressure = TextEditingController();
  final TextEditingController skinThickness = TextEditingController();
  final TextEditingController insulin = TextEditingController();
  final TextEditingController height = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController age = TextEditingController();

  Map<String, bool> familyHistory = {
    "Ayah": false,
    "Ibu": false,
    "Anak": false,
    "Cucu": false,
    "Kakek": false,
    "Nenek": false,
  };

  double getFamilyHistoryScore() {
    return familyHistory.values.where((v) => v).length / familyHistory.length;
  }

  Map<String, dynamic> collectInputData() {
    return {
      'pregnancies': int.tryParse(pregnancies.text) ?? 0,
      'glucose': int.tryParse(glucose.text) ?? 0,
      'bloodPressure': int.tryParse(bloodPressure.text) ?? 0,
      'skinThickness': int.tryParse(skinThickness.text) ?? 0,
      'insulin': int.tryParse(insulin.text) ?? 0,
      'height': double.tryParse(height.text) ?? 0,
      'weight': double.tryParse(weight.text) ?? 0,
      'age': int.tryParse(age.text) ?? 0,
      'familyHistoryScore': getFamilyHistoryScore(),
    };
  }

  void showPredictionPopup(Map<String, dynamic> result) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("HASIL PREDIKSI",
                style: TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Kemungkinan Anda Terkena Diabetes: ${result['probability']}%"),
            Text("Status Prediksi: (${result['status']})",
                style: const TextStyle(
                    color: Colors.purple, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, String hint, TextEditingController controller) {
    return Expanded(
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontFamily: 'Comfortaa',
          fontSize: 13
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 13
          ),
          hintText: 'Contoh: ' + hint,
          hintStyle: TextStyle(
            fontFamily: 'Comfortaa',
            fontSize: 13
          ),
          contentPadding: EdgeInsets.all(5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double familyScore = getFamilyHistoryScore();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Menu Prediksi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage()),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePagen()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('images/profile_picture.jpeg'),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    buildTextField("Jumlah Kehamilan", "2", pregnancies),
                    buildTextField("Glukosa (mg/dL)", "86", glucose),
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    buildTextField("Tekanan Darah (mm Hg)", "72", bloodPressure),
                    buildTextField("Ketebalan Kulit (mm)", "35", skinThickness),
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    buildTextField("Insulin (muU/mL)", "94", insulin),
                    buildTextField("Tinggi Badan (cm)", "160", height),
                  ],
                ),
                Row(
                  spacing: 10,
                  children: [
                    buildTextField("Berat Badan (kg)", "60", weight),
                    buildTextField("Umur", "35", age),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            const Text("Masukkan riwayat diabetes pada keluarga Anda:",
                style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 10,
              children: familyHistory.keys.map((key) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: familyHistory[key],
                      onChanged: (value) {
                        setState(() {
                          familyHistory[key] = value!;
                        });
                      },
                    ),
                    Text(key),
                  ],
                );
              }).toList(),
            ),
            Text(
              "Skor Riwayat: $familyScore",
              style: const TextStyle(color: Colors.deepPurple)
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Collect input data
                Map<String, dynamic> inputData = collectInputData();
                // Perform prediction
                Map<String, dynamic> result = await predictDiabetes(inputData);
                // Show result
                showPredictionPopup(result);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text(
                "Cek Diabetes Saya!",
                style: TextStyle(color: Colors.white)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Riwayat Prediksi',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationPage()),
              );
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePagen()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('images/profile_picture.jpeg'),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final history = snapshot.data!;
          if (history.isEmpty) {
            return const Center(child: Text('Belum ada riwayat.'));
          }
          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item['result'] == 'Positif' 
                        ? Colors.red.withOpacity(0.2)
                        : Colors.green.withOpacity(0.2),
                    child: Icon(
                      item['result'] == 'Positif' ? Icons.warning : Icons.check,
                      color: item['result'] == 'Positif' ? Colors.red : Colors.green,
                    ),
                  ),
                  title: Text(
                    'Tanggal: ${item['date']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hasil: ${item['result']}'),
                      Text('Probabilitas: ${item['probability']}%'),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageController languageController = Get.put(LanguageController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button and title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'setting'.tr,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Profile section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          AssetImage('images/profile_picture.jpeg'),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Kahfi Adam',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Kahfiadam@gmail.com'),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Content section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'content'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.history, color: Colors.purple[200]),
              title: Text('history'.tr),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),

            ListTile(
              leading:
                  Icon(Icons.notifications_none, color: Colors.purple[200]),
              title: Text('notification'.tr),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {},
            ),

            const SizedBox(height: 16),

            // Preferences section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'preferences'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            ListTile(
              leading: Icon(Icons.language, color: Colors.purple[200]),
              title: Text('language'.tr),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() {
                    String currentLocale = Get.locale?.languageCode ?? 'id';
                    String languageName = {
                          'id': 'Indonesia',
                          'en': 'English',
                          'es': 'Spanish',
                        }[currentLocale] ??
                        'Indonesia';
                    return Text(languageName);
                  }),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => const LanguageController(),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.abc, color: Colors.red),
              title: Text(
                'logout'.tr,
                style: const TextStyle(color: Colors.red),
              ),
              onTap: () {
                Get.offAll(() => LandingPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageController extends StatelessWidget {
  const LanguageController({super.key});

  @override
  Widget build(BuildContext context) {
    final BahasaController languageController =
        Get.find<BahasaController>();

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Indonesia'),
            onTap: () {
              languageController.changeLanguage('id');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('English'),
            onTap: () {
              languageController.changeLanguage('en');
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Spanish'),
            onTap: () {
              languageController.changeLanguage('es');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class Food3Page extends StatelessWidget {
  const Food3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Makanan 3')),
      body: Center(child: Image.asset('images/food3.png')),
    );
  }
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = List.generate(4, (_) {
      return {
        'title': 'Tim Developper...',
        'date': 'June 02, 2025',
        'message':
            'Fitur ini masih dalam tahap pengembangan.',
      };
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tombol kembali
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.pop(context),
                  ),

                  const Text(
                    'Notification',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Avatar di kanan atas
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('images/profile_picture.jpeg'),
                  ),
                ],
              ),
            ),

            // Notifikasi list
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notif = notifications[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NotificationDetailPage(notification: notif),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      notif['title']!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      notif['date']!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  notif['message']!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationDetailPage extends StatelessWidget {
  final Map<String, String> notification;

  const NotificationDetailPage({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(notification['title'] ?? ''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          notification['message'] ?? 'Tidak ada pesan.',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

Future<void> openNearbyHospitals() async {
  // Minta izin lokasi
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
    // Handle jika user tidak memberi izin
    throw Exception('Location permission denied');
  }

  // Ambil posisi sekarang
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  // Format URL Google Maps untuk mencari rumah sakit terdekat
  final url = Uri.parse(
    'https://www.google.com/maps/search/rumah+sakit/@${position.latitude},${position.longitude},15z'
  );

  // Buka Google Maps
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw Exception('Could not launch Google Maps');
  }
}

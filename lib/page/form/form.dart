import 'package:flutter/material.dart';

class DiabetesFormPage extends StatefulWidget {
  @override
  _DiabetesFormPageState createState() => _DiabetesFormPageState();
}

class _DiabetesFormPageState extends State<DiabetesFormPage> {
  // Controllers
  final TextEditingController pregnancies = TextEditingController();
  final TextEditingController glucose = TextEditingController();
  final TextEditingController bloodPressure = TextEditingController();
  final TextEditingController skinThickness = TextEditingController();
  final TextEditingController insulin = TextEditingController();
  final TextEditingController height = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController age = TextEditingController();

  // Family history checkboxes
  Map<String, bool> familyHistory = {
    "Ayah": false,
    "Ibu": false,
    "Anak": false,
    "Cucu": false,
    "Kakek": false,
    "Nenek": false,
  };

  int getFamilyHistoryScore() {
    return familyHistory.values.where((v) => v).length * 10;
  }

  void showPredictionPopup() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.pink[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("HASIL PREDIKSI", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Kemungkinan Anda Terkena Diabetes: 87%"),
            Text("Status Prediksi: (Positif)", style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int familyScore = getFamilyHistoryScore();

    return Scaffold(
      appBar: AppBar(title: Text("Menu Prediksi")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                buildTextField("Jumlah Kehamilan", pregnancies),
                buildTextField("Glukosa (mg/dL)", glucose),
                buildTextField("Tekanan Darah (mm Hg)", bloodPressure),
                buildTextField("Ketebalan Kulit (mm)", skinThickness),
                buildTextField("Insulin (muU/mL)", insulin),
                buildTextField("Tinggi Badan (cm)", height),
                buildTextField("Berat Badan (kg)", weight),
                buildTextField("Umur", age),
              ],
            ),
            SizedBox(height: 20),
            Text("Masukkan riwayat diabetes pada keluarga Anda:", style: TextStyle(fontWeight: FontWeight.bold)),
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
            Text("Skor Riwayat: $familyScore", style: TextStyle(color: Colors.deepPurple)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: showPredictionPopup,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: Text("Cek Diabetes Saya!", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.document_scanner), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ""),
        ],
      ),
    );
  }
}

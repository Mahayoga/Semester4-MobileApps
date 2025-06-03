import 'package:flutter/material.dart';
import 'dart:math' as math;

class Food1Page extends StatefulWidget {
  const Food1Page({super.key});

  @override
  State<Food1Page> createState() => _Food1PageState();
}

class _Food1PageState extends State<Food1Page> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _arrowAnimation;
  late Animation<double> _arrowScale;
  final PageController _pageController = PageController();
  int _currentImage = 0;

  final List<String> foodImages = [
    'assets/images/food1.png',
    'assets/images/food2.png',
    'assets/images/food3.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _arrowAnimation = Tween<double>(begin: 1.5 * math.pi, end: math.pi + math.pi / 6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _arrowScale = Tween<double>(begin: 0.7, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.purple),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Rekomendasi Makanan', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.purple),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_picture.jpg'),
              radius: 18,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text('Nasi Goreng', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 150,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView.builder(
                            controller: _pageController,
                            itemCount: foodImages.length,
                            onPageChanged: (idx) {
                              setState(() {
                                _currentImage = idx;
                              });
                            },
                            itemBuilder: (context, idx) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  foodImages[idx],
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          ),
                          Positioned(
                            bottom: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(foodImages.length, (idx) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentImage == idx ? Colors.purple : Colors.grey[300],
                                ),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 170,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      decoration: BoxDecoration(
                        color: Color(0xFFF3F0F9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text('Status Makanan', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 140,
                                height: 100,
                                child: CustomPaint(
                                  painter: MeteranBadPainter(),
                                ),
                              ),
                              Positioned(
                                bottom: 38,
                                child: AnimatedBuilder(
                                  animation: _arrowAnimation,
                                  builder: (context, child) {
                                    return Transform.rotate(
                                      angle: _arrowAnimation.value,
                                      alignment: Alignment.bottomCenter,
                                      child: const Icon(Icons.arrow_upward, size: 38, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              const Positioned(
                                bottom: 0,
                                child: Text('BAD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                margin: const EdgeInsets.only(bottom: 18),
                decoration: BoxDecoration(
                  color: Color(0xFFF3F0F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Deskripsi Makanan', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(
                      'Nasi goreng mengandung kalori, karbohidrat, lemak, protein, dan berbagai vitamin serta mineral, tergantung pada bahan-bahan tambahan yang digunakan. Nasi goreng juga mengandung serat dan natrium.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Color(0xFFF3F0F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Informasi Gizi', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('• Kalori: 300–400 kcal'),
                              Text('• Karbohidrat: 40–60 gram (tergantung jumlah nasi)'),
                              Text('• Lemak: 10–20 gram (tergantung minyak dan tambahan seperti daging)'),
                              Text('• Protein: 8–15 gram (dari telur/daging)'),
                              Text('• Serat: 2–4 gram (jika ada sayuran)'),
                              Text('• Natrium: 800–1200 mg (tinggi garam)'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MeteranBadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    // Setengah lingkaran (180 derajat)
    final double startAngle = math.pi; // 180 derajat
    final double sweepAngle = math.pi; // 180 derajat
    final double section = sweepAngle / 3;

    // Merah
    paint.color = Colors.red;
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height * 2), startAngle, section, false, paint);

    // Kuning
    paint.color = Colors.yellow;
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height * 2), startAngle + section, section, false, paint);

    // Hijau
    paint.color = Colors.green;
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height * 2), startAngle + 2 * section, section, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MeteranArrowPainter extends CustomPainter {
  final double angle; // dalam radian
  MeteranArrowPainter({required this.angle});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final length = size.height * 1.1;
    final arrowPaint = Paint()
      ..color = Colors.grey[700]!
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);

    // Bayangan panah
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.18)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final arrowEnd = Offset(
      center.dx + length * math.cos(angle),
      center.dy + length * math.sin(angle),
    );
    // Shadow
    canvas.drawLine(center, arrowEnd, shadowPaint);
    // Arrow
    canvas.drawLine(center, arrowEnd, arrowPaint);

    // Kepala panah
    final headPaint = Paint()
      ..color = Colors.grey[700]!
      ..strokeWidth = 8
      ..style = PaintingStyle.fill;
    final headSize = 18.0;
    final headAngle = math.pi / 10;
    final path = Path();
    path.moveTo(arrowEnd.dx, arrowEnd.dy);
    path.lineTo(
      arrowEnd.dx - headSize * math.cos(angle - headAngle),
      arrowEnd.dy - headSize * math.sin(angle - headAngle),
    );
    path.lineTo(
      arrowEnd.dx - headSize * math.cos(angle + headAngle),
      arrowEnd.dy - headSize * math.sin(angle + headAngle),
    );
    path.close();
    canvas.drawPath(path, headPaint);
  }

  @override
  bool shouldRepaint(covariant MeteranArrowPainter oldDelegate) => oldDelegate.angle != angle;
}

class Food2Page extends StatelessWidget {
  const Food2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Makanan 2')),
      body: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/food2.png'),
            Text(
              textAlign: TextAlign.center,
              'Developer: Fitur ini masih dalam tahap pengembangan',
              style: TextStyle(
                
              ),
            )
          ],
        )
      ),
    );
  }
}
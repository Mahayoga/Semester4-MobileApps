import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {

  @override
  State<LandingPage> createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 239, 197, 243),
        title: Text(
          'Aplikasi Pendeteksi Diabetes',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontFamily: 'Consolas'
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 239, 197, 243),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/person_landing.png')
                  )
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(230),
                    topRight: Radius.circular(230)
                  ),
                ),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 0,
                    children: [
                      SizedBox(
                        child: Text('Hello World'),
                      )
                    ],
                  )
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
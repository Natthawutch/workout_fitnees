import 'package:flutter/material.dart';
import 'dart:async';

import '../GenderSelection/GenderSelectionPage.dart';

class GoalFocusScreen extends StatefulWidget {
  @override
  _GoalFocusScreenState createState() => _GoalFocusScreenState();
}

class _GoalFocusScreenState extends State<GoalFocusScreen> {
  @override
  void initState() {
    super.initState();
    // ตั้งเวลาให้แสดงหน้านี้ 3 วินาทีแล้วเปลี่ยนไปหน้า GenderSelectionPage
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GenderSelectionPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade300, Colors.blue.shade800],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20), // ขยับให้ชิดซ้าย
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // จัดตรงกลางแนวตั้ง
            crossAxisAlignment: CrossAxisAlignment.start, // ชิดซ้าย
            children: [
              const Text(
                "PART 1",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "GOAL & FOCUS",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.lightBlueAccent.shade100,
                    size: 32,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ใส่หน้า GenderSelectionPage ไว้ที่นี่ หรือเปลี่ยนไปหน้าที่ต้องการ
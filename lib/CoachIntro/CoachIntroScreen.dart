import 'package:flutter/material.dart';

import '../Loading/GoalFocusScreen .dart';

class CoachIntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Spacer(), // เว้นระยะด้านบน

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "👋", // อีโมจิ
                        style: TextStyle(fontSize: 25),
                      ),
                      SizedBox(height: 10), // ระยะห่าง
                      Text(
                        "Hello!",
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: "Georgia",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://as1.ftcdn.net/v2/jpg/05/24/37/84/1000_F_524378456_7iH4roEgy8t8351zKypjRumlIbRfwhIO.jpg",
                    ), // รูปโค้ช
                  ),
                ],
              ),

              SizedBox(height: 10), // ระยะห่าง

              Text(
                "I'm your personal coach.\nHere are some questions to tailor a",
                style: TextStyle(
                    fontSize: 15, color: Colors.black, fontFamily: "Georgia"),
              ),

              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      text: "personalized plan",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue, // ทำตัวหนังสือเป็นสีฟ้า
                        fontFamily: "Georgia",
                      ),
                      children: [
                        TextSpan(
                          text: " for you.",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Spacer(),

              // ปุ่ม "I'M READY"
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GoalFocusScreen()), // แก้ให้เป็นหน้าที่ต้องการไป
                  );
                },
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      "I'M READY",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Georgia",
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40), // เว้นที่ด้านล่าง
            ],
          ),
        ),
      ),
    );
  }
}

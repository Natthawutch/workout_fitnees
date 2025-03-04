import 'package:flutter/material.dart';
import 'dart:async';

import 'package:workout_fitness/SignUp/SignUpScreen.dart';

import '../CoachIntro/CoachIntroScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final List<String> slogans = [
    "Workout at home, let's get started!",
    "Join our first group of users today!",
    "A personalized workout plan just for you!",
  ];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % slogans.length;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image with Gradient Overlay
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.squarespace-cdn.com/content/v1/603a73e7e541b709395810f2/7ce535a7-8047-4ec4-99ce-5d3c2eb41d57/Adrien+lunges.JPEG',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Animated Slogan Text with Blue Effect
                SizedBox(
                  height: 80, // กำหนดความสูงคงที่
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.5, 0), // เริ่มจากขวา
                                end: Offset.zero,
                              ).animate(animation),
                              child: ScaleTransition(
                                scale: Tween<double>(
                                  begin: 0.8, // เริ่มจากเล็กลง
                                  end: 1.0,
                                ).animate(animation),
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          slogans[_currentIndex],
                          key: ValueKey<String>(slogans[_currentIndex]),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "Georgia",
                            shadows: [
                              Shadow(
                                blurRadius: 8,
                                color: Colors.black54,
                                offset: Offset(2, 2),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 180),

                // Gradient START Button
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CoachIntroScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 20),
                      ),
                      child: const Text(
                        "START",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Georgia",
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Already a user? + Login Option
                Row(
                  children: [
                    const Expanded(
                      child: Divider(
                        color: Colors.white54,
                        thickness: 0.5,
                        indent: 1,
                        endIndent: 10, // ลดให้เส้นไม่ติดตัวหนังสือ
                      ),
                    ),
                    Opacity(
                      opacity: 0.6,
                      child: const Text(
                        "Already our user?",
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                          fontFamily: "Georgia",
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        color: Colors.white54,
                        thickness: 0.5,
                        indent: 10, // ลดให้เส้นไม่ติดตัวหนังสือ
                        endIndent: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      //showDragHandle: true,
                      isScrollControlled: true, // ให้มีขนาดเล็กลง
                      context: context,
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) => Container(
                        padding: EdgeInsets.all(16),
                        height: MediaQuery.of(context).size.height *
                            0.4, // ปรับให้ไม่เต็มจอ
                        child: SignUpScreen(), // ใช้หน้าจอสมัคร
                      ),
                    );
                  },
                  child: Text(
                    "Continue with your existing account >",
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontFamily: "Georgia"),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

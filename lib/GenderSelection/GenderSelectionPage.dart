import 'package:flutter/material.dart';

class GenderSelectionPage extends StatefulWidget {
  @override
  _GenderSelectionPageState createState() => _GenderSelectionPageState();
}

class _GenderSelectionPageState extends State<GenderSelectionPage> {
  String? selectedGender;

  void selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.arrow_back, size: 28, color: Colors.black),
            ),

            // Progress Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(
                value: 0.3, // เปลี่ยนค่าความก้าวหน้าได้
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                minHeight: 4,
              ),
            ),
            SizedBox(height: 20),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "What's your gender?",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),

            // Subtitle with Robot Icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.network(
                    'https://w7.pngwing.com/pngs/292/543/png-transparent-robot-humanoid-robot-military-robot-artificial-intelligence-robotics-electronics-desktop-wallpaper-robot.png',
                    width: 50,
                    height: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.android, size: 24, color: Colors.blue),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "This will help us tailor your workout to match your metabolic rate perfectly.",
                      style:
                          TextStyle(color: Colors.grey.shade600, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Gender Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  genderCard("Male",
                      "https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTA4L3Jhd3BpeGVsX29mZmljZV8zNF9yZWFsX3Bob3RvX29mX3dlaWdodF90cmFpbmluZ193b3Jrb3V0X3NpbXBsZV82OWEzZTY0ZS03ODZjLTQ5YjAtOTE2YS03NDVmM2YzMGY2YjIucG5n.png"),
                  genderCard("Female",
                      "https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDI0LTA3L3Jhd3BpeGVsX29mZmljZV8zNF9waG90b19vZl9oYXBweV93b21hbl9vbmVfaGFuZF9ob2xkX3NtYWxsX2R1bV85OThhNWRkZC03M2Y4LTQxNzgtYTA1ZC1hNGFjYzk0MDI3ZjUucG5n.png"),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Other Option
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Other / I'd rather not say",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            Spacer(),

            // Next Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: selectedGender == null ? null : () {},
                child: Text("Next", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Gender Card Widget
  Widget genderCard(String gender, String imageUrl) {
    bool isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () => selectGender(gender),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.42,
        height: 370, // 👈 ปรับความสูงของ Card ให้สูงขึ้น
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade100 : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                height: 280, // 👈 เพิ่มความสูงของรูปภาพ
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.person, size: 100, color: Colors.grey),
              ),
            ),
            SizedBox(height: 12), // 👈 เพิ่มระยะห่างให้ดูสมดุลขึ้น
            Text(
              gender,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: Colors.blue, size: 24),
          ],
        ),
      ),
    );
  }
}

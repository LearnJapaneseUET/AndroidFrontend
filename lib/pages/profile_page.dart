import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:nihongo/pages/feedback_page.dart';
import 'package:nihongo/pages/mail_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8980F0),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Profile",
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Icon(Icons.edit_square, color: Colors.white)
          ],
        ),
      ),
      body: 
        Column(
          children: [
            Container(
              color: const Color(0xFF8980F0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/ava_cat.jpg')
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'user_name',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      signUserOut(); // Added parentheses to call the method
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8980F0),
                    ),
                    child: const Text('Đăng xuất', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SendMail()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Colors.white, // Màu nền nút
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Color.fromRGBO(0, 0, 0, 1), // Màu viền
                          width: 2, // Độ dày viền
                        ),
                        borderRadius: BorderRadius.circular(30), // Độ bo góc
                      ),
                    ),
                    child: const Text('Đánh giá'),
                  ),
                ]
              ),
            ),
          ],
        ),
    );
  }
}

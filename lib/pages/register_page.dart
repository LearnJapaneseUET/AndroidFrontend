import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nihongo/components/my_button.dart';
import 'package:nihongo/components/my_textfield.dart';
import 'package:nihongo/components/square_tile.dart';
import 'package:nihongo/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user in method
  void signUserUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try creating the user
    try {
      // check if password is confirmed
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        // show error message, passwords don't match
        showErrorMessage("Password don't match!");
      }

      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // show error message
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            backgroundColor: Colors.purple,
            title: Center(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8980F0),
        title: const Center(
          child: Text(
                "Đăng ký",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Noto Sans',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
        ),
      ),
      backgroundColor:  const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Add the container with the image at the top
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/appbar.png'),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                  ),
                ),
                height: 200, // Adjust the height of the image container
              ),
              // Main content will be placed under the image container
              Padding(
                padding: const EdgeInsets.only(top: 30), // Add padding to avoid overlap
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),

                      // username textfield
                      MyTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                      ),

                      const SizedBox(height: 10),

                      // password textfield
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Mật khẩu',
                        obscureText: true,
                      ),

                      const SizedBox(height: 10),

                      // confirm password textfield
                      MyTextField(
                        controller: confirmPasswordController,
                        hintText: 'Nhập lại mật khẩu',
                        obscureText: true,
                      ),

                      const SizedBox(height: 25),

                      // sign in button
                      MyButton(
                        text: 'Đăng ký',
                        onTap: signUserUp,
                      ),

                      const SizedBox(height: 50),

                      // or continue with
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                'Đăng nhập bằng',
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // google + apple sign in buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // google button
                          SquareTile(
                              onTap: () => AuthService().signInWithGoogle(),
                              imagePath: 'assets/images/google.png'),

                          const SizedBox(width: 25),

                          // apple button
                          SquareTile(
                              onTap: () {}, imagePath: 'assets/images/apple.png')
                        ],
                      ),

                      const SizedBox(height: 20),

                      // not a member? register now
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Bạn đã có tài khoản',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: const Text(
                              'Đăng nhập',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ]
          ),
        )
      )
    );
  }
}

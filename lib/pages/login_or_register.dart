import 'package:flutter/material.dart';
import 'package:nihongo/pages/login_page.dart';
import 'package:nihongo/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});
  
  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

  class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
    // initially show log in page
    bool showLoginPage = true;

    // toggle between login and register page
    void TogglePages() {
      setState(() {
        showLoginPage = !showLoginPage;
      });
    }

    @override
    Widget build(BuildContext context) {
      if (showLoginPage) {
        return LoginPage(
          onTap: TogglePages,
        );
      } else {
        return RegisterPage(
          onTap: TogglePages,
        );
      }
    }
}
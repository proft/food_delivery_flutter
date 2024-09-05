import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/views/login_view.dart';
import 'package:food_delivery_flutter/views/register_view.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginPage = true;

  void toggleViews() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginView(onTap: toggleViews);
    } else {
      return RegisterView(onTap: toggleViews);
    }
  }
}

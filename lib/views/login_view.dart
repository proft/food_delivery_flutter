import 'package:flutter/material.dart';
import 'package:food_delivery_flutter/components/my_button.dart';
import 'package:food_delivery_flutter/components/my_textfield.dart';
import 'package:food_delivery_flutter/services/auth_service.dart';
import 'package:food_delivery_flutter/views/home_view.dart';

class LoginView extends StatefulWidget {
  final void Function()? onTap;

  const LoginView({super.key, required this.onTap});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              Icons.lock_open_rounded,
              size: 72,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            const SizedBox(height: 25),
            Text("Food Delivery App",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary)),
            const SizedBox(height: 25),
            MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false),
            const SizedBox(height: 10),
            MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true),
            const SizedBox(height: 10),
            MyButton(onTap: login, text: "Sign in"),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary)),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text("Register now",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            )
          ]),
        ));
  }

  void login() async {
    final authService = AuthService();
      try {
        await authService.signInWithEmail(emailController.text, passwordController.text);
      } catch (e) {
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ));
      }


    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeView()));
  }
}
